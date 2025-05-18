// @ts-check
import { defineConfig } from 'astro/config';
import elm from 'vite-plugin-elm';

import tailwindcss from '@tailwindcss/vite';

// https://astro.build/config
export default defineConfig({
    vite: {
      plugins: [elm(), tailwindcss()]
    }
  });