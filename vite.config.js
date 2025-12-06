import { defineConfig } from 'vite';
import { resolve } from 'path';

export default defineConfig({
    base: '/Calculator/',
    build: {
        rollupOptions: {
            input: {
                main: resolve(__dirname, 'index.html'),
                hydrochloric: resolve(__dirname, 'hydrochloric-acid-calculator.html'),
                mixed_alkali: resolve(__dirname, 'mixed-alkali-calculator.html'),
                edta: resolve(__dirname, 'EDTA标准溶液配制_R2.html'),
                pb_bi: resolve(__dirname, '铅、铋混合溶液含量_R2.1.html'),
            },
        },
    },
});
