import { defineConfig } from "vite";
import { viteSingleFile } from "vite-plugin-singlefile";

// `vite build --mode single` makes one self-contained HTML file (story, panels and code inlined)
// for sharing the demo as a single page. The normal build is for GitHub Pages.
export default defineConfig(({ mode }) => ({
  base: "./",
  plugins: mode === "single" ? [viteSingleFile()] : [],
  build: { outDir: mode === "single" ? "dist-single" : "dist", assetsInlineLimit: mode === "single" ? 100_000_000 : 4096 },
}));
