import js from '@eslint/js';
import eslintConfigPrettier from 'eslint-config-prettier';
import tseslint from 'typescript-eslint';
import pluginReactHooks from 'eslint-plugin-react-hooks';
import pluginReact from 'eslint-plugin-react';
import turboPlugin from 'eslint-plugin-turbo';
import onlyWarn from 'eslint-plugin-only-warn';
import globals from 'globals';

/**
 * A shared ESLint configuration with Airbnb-inspired rules for React components.
 *
 * @type {import("eslint").Linter.Config[]}
 * */
export const airbnbConfig = [
  js.configs.recommended,
  ...tseslint.configs.recommended,
  {
    ...pluginReact.configs.flat.recommended,
    languageOptions: {
      ...pluginReact.configs.flat.recommended.languageOptions,
      globals: {
        ...globals.browser,
        ...globals.node,
      },
    },
  },
  {
    plugins: {
      'react-hooks': pluginReactHooks,
    },
    settings: { react: { version: 'detect' } },
    rules: {
      ...pluginReactHooks.configs.recommended.rules,
    },
  },
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
    plugins: {
      onlyWarn,
    },
  },
  {
    languageOptions: {
      globals: {
        // Node.js globals for monorepo tooling
        process: 'readonly',
        Buffer: 'readonly',
        __dirname: 'readonly',
        __filename: 'readonly',
      },
    },
  },
  {
    rules: {
      // Airbnb-inspired rules
      // React scope no longer necessary with new JSX transform
      'react/react-in-jsx-scope': 'off',
      // Allow JSX in .tsx files
      'react/jsx-filename-extension': ['error', { extensions: ['.jsx', '.tsx'] }],
      // More flexible with default props in TypeScript
      'react/require-default-props': 'off',
      // Consistent quote style
      quotes: ['error', 'single'],
      // Semicolons required
      semi: ['error', 'always'],
      // Consistent comma dangle
      'comma-dangle': ['error', 'always-multiline'],
      // Consistent indentation
      indent: ['error', 2],
      // No unused variables
      '@typescript-eslint/no-unused-vars': ['error'],
      // Allow console for development and CLI tools
      'no-console': ['warn'],
      // More flexible with underscore dangle for private methods
      'no-underscore-dangle': [
        'error',
        {
          allow: ['__dirname', '__filename', '_id', '_rev'],
          allowAfterThis: true,
          allowAfterSuper: true,
        },
      ],
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
    ],
  },
];
