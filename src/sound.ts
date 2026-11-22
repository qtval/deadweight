// Scene sound, synthesised live with WebAudio: no audio files, nothing borrowed.
// Each panel has a preset (river, wind, leaves, crowd, drone + occasional bells, birds, fire, cart, drips);
// changing panel crossfades to the new preset. Starts only after a tap (browser rule), stops when the tab is hidden.

type Layer = "river" | "wind" | "leaves" | "crowd" | "drone";
type Event = "bells" | "birds" | "fire" | "cart" | "drip";
type Preset = Partial<Record<Layer | Event, number>>;

const PRESETS: Record<string, Preset> = {
  title: { wind: 0.35, drone: 0.25 },
  greywater_ford_night: { river: 0.55, wind: 0.30, drone: 0.15 },
  greywater_water_churn: { river: 1.0, wind: 0.2, drone: 0.25 },
  greywater_bank_body: { river: 0.40, wind: 0.30, drip: 0.5, drone: 0.25 },
  greywater_marrow_wading: { river: 0.50, wind: 0.25, drip: 0.3, drone: 0.2 },
  greywater_wrapping: { river: 0.30, wind: 0.35, drone: 0.2 },
  greywater_dawn_cart: { river: 0.30, wind: 0.20, birds: 0.5, drone: 0.1 },
  greywater_breastplate_silver: { river: 0.25, wind: 0.15, birds: 0.2, drone: 0.3 },
  road_to_stint_morning: { wind: 0.30, birds: 0.6, cart: 0.8 },
  road_beech_wood_noon: { leaves: 0.55, wind: 0.20, birds: 0.7 },
  stint_bridge_dusk: { river: 0.45, wind: 0.25, bells: 0.25, crowd: 0.10 },
  stint_tollhouse: { crowd: 0.35, fire: 0.6, wind: 0.15 },
  stint_square_bells: { crowd: 0.55, bells: 0.9, wind: 0.15 },
  stint_chapel_door: { wind: 0.30, drone: 0.30, bells: 0.08 },
};
const DEFAULT: Preset = { wind: 0.3, drone: 0.15 };

let ctx: AudioContext | null = null;
let master: GainNode;
const gains = {} as Record<Layer, GainNode>;
let rates: Preset = {};
let current = "";
let muted = false;
let tick = 0;
let noise: AudioBuffer;

function makeNoise(c: AudioContext) {
  const b = c.createBuffer(2, c.sampleRate * 4, c.sampleRate);
  for (let ch = 0; ch < 2; ch++) {
    const d = b.getChannelData(ch);
    let brown = 0;
    for (let i = 0; i < d.length; i++) {
      const w = Math.random() * 2 - 1;
      brown = (brown + 0.02 * w) / 1.02; // gentle brown tilt mixed with white
      d[i] = w * 0.35 + brown * 3.5;
    }
  }
  return b;
}

function lfo(c: AudioContext, freq: number, depth: number, target: AudioParam) {
  const o = c.createOscillator();
  o.frequency.value = freq;
  const g = c.createGain();
  g.gain.value = depth;
  o.connect(g).connect(target);
  o.start();
}

function noiseLayer(c: AudioContext, chain: AudioNode[], out: GainNode) {
  const src = c.createBufferSource();
  src.buffer = noise;
  src.loop = true;
  src.loopStart = Math.random() * 2;
  let n: AudioNode = src;
  for (const f of chain) { n.connect(f); n = f; }
  n.connect(out);
  src.start(0, Math.random() * 3);
}

function filter(c: AudioContext, type: BiquadFilterType, f: number, q = 0.7) {
  const b = c.createBiquadFilter();
  b.type = type; b.frequency.value = f; b.Q.value = q;
  return b;
}

function build(c: AudioContext) {
  noise = makeNoise(c);
  master = c.createGain();
  master.gain.value = muted ? 0 : 0.55;
  const comp = c.createDynamicsCompressor();
  master.connect(comp).connect(c.destination);
  for (const k of ["river", "wind", "leaves", "crowd", "drone"] as Layer[]) {
    gains[k] = c.createGain();
    gains[k].gain.value = 0;
    gains[k].connect(master);
  }
  // river: low rush plus a little babble
  const rLow = filter(c, "lowpass", 650);
  const rAmp = c.createGain(); rAmp.gain.value = 0.9;
  lfo(c, 0.07, 0.15, rAmp.gain);
  noiseLayer(c, [rLow, rAmp], gains.river);
  const rBab = filter(c, "bandpass", 1700, 1.2);
  const rBabAmp = c.createGain(); rBabAmp.gain.value = 0.25;
  lfo(c, 0.31, 0.12, rBabAmp.gain);
  noiseLayer(c, [rBab, rBabAmp], gains.river);
  // wind: a slowly moving band
  const w = filter(c, "bandpass", 520, 0.8);
  lfo(c, 0.045, 260, w.frequency);
  const wAmp = c.createGain(); wAmp.gain.value = 0.7;
  lfo(c, 0.06, 0.35, wAmp.gain);
  noiseLayer(c, [w, wAmp], gains.wind);
  // leaves
  const l = filter(c, "highpass", 2600);
  const lAmp = c.createGain(); lAmp.gain.value = 0.3;
  lfo(c, 0.23, 0.2, lAmp.gain);
  noiseLayer(c, [l, lAmp], gains.leaves);
  // crowd murmur: two vowel-ish bands with uneven swells
  for (const [f, q, r] of [[520, 2.2, 0.7], [1150, 3, 1.3]] as const) {
    const b = filter(c, "bandpass", f, q);
    const a = c.createGain(); a.gain.value = 0.6;
    lfo(c, r, 0.35, a.gain);
    lfo(c, r * 0.37, 0.2, a.gain);
    noiseLayer(c, [b, a], gains.crowd);
  }
  // drone: low strings
  const dl = filter(c, "lowpass", 320);
  for (const f of [55, 55.35, 82.4]) {
    const o = c.createOscillator();
    o.type = "sawtooth"; o.frequency.value = f;
    const g = c.createGain(); g.gain.value = f > 60 ? 0.05 : 0.09;
    o.connect(g).connect(dl);
    o.start();
  }
  dl.connect(gains.drone);
}

// ---- occasional sounds ------------------------------------------------------
function env(g: GainNode, t: number, peak: number, attack: number, decay: number) {
  g.gain.setValueAtTime(0.0001, t);
  g.gain.exponentialRampToValueAtTime(peak, t + attack);
  g.gain.exponentialRampToValueAtTime(0.0001, t + attack + decay);
}

function bell(c: AudioContext, f0: number, amp: number) {
  const t = c.currentTime;
  const pan = c.createStereoPanner(); pan.pan.value = Math.random() * 1.2 - 0.6;
  pan.connect(master);
  for (const [r, a, d] of [[0.5, 1, 5], [1, 0.8, 4], [1.19, 0.5, 3], [1.5, 0.4, 2.5], [2, 0.45, 2], [2.51, 0.25, 1.5], [3.01, 0.15, 1.2]]) {
    const o = c.createOscillator(); o.frequency.value = f0 * r;
    const g = c.createGain(); env(g, t, amp * a * 0.06, 0.005, d);
    o.connect(g).connect(pan); o.start(t); o.stop(t + d + 0.1);
  }
}

function bird(c: AudioContext, amp: number) {
  const t0 = c.currentTime;
  const n = 2 + Math.floor(Math.random() * 3);
  const base = 2400 + Math.random() * 1600;
  const pan = c.createStereoPanner(); pan.pan.value = Math.random() * 1.6 - 0.8;
  pan.connect(master);
  for (let i = 0; i < n; i++) {
    const t = t0 + i * (0.09 + Math.random() * 0.06);
    const o = c.createOscillator(); o.type = "sine";
    o.frequency.setValueAtTime(base, t);
    o.frequency.exponentialRampToValueAtTime(base * (1.3 + Math.random() * 0.4), t + 0.06);
    const g = c.createGain(); env(g, t, amp * 0.025, 0.01, 0.07);
    o.connect(g).connect(pan); o.start(t); o.stop(t + 0.12);
  }
}

function burst(c: AudioContext, type: BiquadFilterType, f: number, len: number, amp: number, pan = 0) {
  const t = c.currentTime;
  const s = c.createBufferSource(); s.buffer = noise; s.playbackRate.value = 0.8 + Math.random() * 0.4;
  const b = filter(c, type, f, 1);
  const g = c.createGain(); env(g, t, amp, 0.002, len);
  const p = c.createStereoPanner(); p.pan.value = pan;
  s.connect(b).connect(g).connect(p).connect(master);
  s.start(t, Math.random() * 3); s.stop(t + len + 0.05);
}

function creak(c: AudioContext, amp: number) {
  const t = c.currentTime;
  const o = c.createOscillator(); o.type = "sawtooth";
  o.frequency.setValueAtTime(150 + Math.random() * 40, t);
  o.frequency.linearRampToValueAtTime(190 + Math.random() * 60, t + 0.25);
  const b = filter(c, "bandpass", 900, 4);
  const g = c.createGain(); env(g, t, amp * 0.03, 0.03, 0.25);
  o.connect(b).connect(g).connect(master); o.start(t); o.stop(t + 0.35);
  burst(c, "lowpass", 180, 0.12, amp * 0.12);
}

function drip(c: AudioContext, amp: number) {
  const t = c.currentTime;
  const o = c.createOscillator();
  o.frequency.setValueAtTime(1300 + Math.random() * 600, t);
  o.frequency.exponentialRampToValueAtTime(500, t + 0.05);
  const g = c.createGain(); env(g, t, amp * 0.03, 0.002, 0.06);
  o.connect(g).connect(master); o.start(t); o.stop(t + 0.1);
}

let cartPhase = 0;
function onTick() {
  if (!ctx || ctx.state !== "running" || muted) return;
  const r = rates;
  const chance = (x = 0, per = 1) => Math.random() < x * per;
  if (chance(r.bells, 0.035)) bell(ctx, [196, 233, 174, 147][Math.floor(Math.random() * 4)], r.bells!);
  if (chance(r.birds, 0.06)) bird(ctx, r.birds!);
  if (r.fire) for (let i = 0; i < 3; i++) if (chance(r.fire, 0.25)) burst(ctx, "highpass", 1800 + Math.random() * 2000, 0.015 + Math.random() * 0.03, 0.08 * r.fire, Math.random() - 0.5);
  if (r.cart && ++cartPhase % 5 === 0) creak(ctx, r.cart);
  if (chance(r.drip, 0.12)) drip(ctx, r.drip!);
}

function apply(name: string) {
  if (!ctx) return;
  const p = PRESETS[name] ?? DEFAULT;
  rates = p;
  const t = ctx.currentTime;
  for (const k of Object.keys(gains) as Layer[]) {
    gains[k].gain.cancelScheduledValues(t);
    gains[k].gain.setTargetAtTime((p[k] ?? 0) * 0.9, t, 1.1);
  }
}

// ---- public API -------------------------------------------------------------
export const sound = {
  /** Call from a tap/click: creates or resumes the audio. Safe to call often. */
  unlock() {
    try {
      if (!ctx) {
        const AC = window.AudioContext ?? (window as any).webkitAudioContext;
        if (!AC) return;
        ctx = new AC();
        build(ctx);
        apply(current || "title");
        tick = window.setInterval(onTick, 250);
        document.addEventListener("visibilitychange", () => {
          if (!ctx) return;
          if (document.hidden) ctx.suspend(); else if (!muted) ctx.resume();
        });
      }
      if (ctx.state === "suspended" && !muted && !document.hidden) ctx.resume();
    } catch { /* no sound is fine */ }
  },
  scene(name: string) {
    current = name;
    apply(name);
  },
  setMuted(m: boolean) {
    muted = m;
    if (!ctx) return;
    const t = ctx.currentTime;
    master.gain.cancelScheduledValues(t);
    master.gain.setTargetAtTime(m ? 0 : 0.55, t, 0.15);
    if (!m && ctx.state === "suspended" && !document.hidden) ctx.resume();
  },
  get muted() { return muted; },
  /** For the browser test. */
  debug() { return { state: ctx?.state ?? "none", scene: current, muted, layers: Object.fromEntries(Object.entries(gains).map(([k, g]) => [k, +g.gain.value.toFixed(3)])), tick: !!tick }; },
};
