import js from '@eslint/js';
import eslintConfigPrettier from 'eslint-config-prettier';
import turboPlugin from 'eslint-plugin-turbo';

/**
 * Root ESLint configuration for the monorepo.
 * Individual packages override this with their own configurations.
 *
 * @type {import("eslint").Linter.Config[]}
 */
export default [
  js.configs.recommended,
  eslintConfigPrettier,
  {
    plugins: {
      turbo: turboPlugin,
    },
    rules: {
      'turbo/no-undeclared-env-vars': 'warn',
    },
  },
  {
    ignores: [
      'dist/**',
      'build/**',
      '.next/**',
      'node_modules/**',
      'packages/db/generated/**',
      '*.config.js',
      '*.config.mjs',
      '*.config.ts',
      'apps/*/eslint.config.mjs',
      'packages/*/eslint.config.mjs',
    ],
  },
];