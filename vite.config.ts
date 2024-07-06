/// <reference types="vitest" />
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react-swc';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  base: process.env.BASE_URL || '/',
  test: {
    environment: 'jsdom',
    setupFiles: './src/global/setupTests.ts',
    globals: true,
    coverage: {
      include: ['src/**'],
      exclude: ['src/main.tsx'],
    },
  },
});
