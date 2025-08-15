import js from '@eslint/js';
import pluginNext from '@next/eslint-plugin-next';
import eslintConfigPrettier from 'eslint-config-prettier';
import pluginReact from 'eslint-plugin-react';
import pluginReactHooks from 'eslint-plugin-react-hooks';
import globals from 'globals';
import tseslint from 'typescript-eslint';

import { config as baseConfig } from './base.js';

/**
 * A custom ESLint configuration for libraries that use Next.js.
 *
 * @type {import("eslint").Linter.Config[]}
 * */
export const nextJsConfig = [
  ...baseConfig,
  js.configs.recommended,
  eslintConfigPrettier,
  ...tseslint.configs.recommended,
  {
    ...pluginReact.configs.flat.recommended,
    languageOptions: {
      ...pluginReact.configs.flat.recommended.languageOptions,
      globals: {
        ...globals.serviceworker,
      },
    },
  },
  {
    plugins: {
      '@next/next': pluginNext,
    },
    rules: {
      ...pluginNext.configs.recommended.rules,
      ...pluginNext.configs['core-web-vitals'].rules,
    },
  },
  {
    plugins: {
      'react-hooks': pluginReactHooks,
    },
    settings: { react: { version: 'detect' } },
    rules: {
      ...pluginReactHooks.configs.recommended.rules,
      // React scope no longer necessary with new JSX transform.
      'react/react-in-jsx-scope': 'off',
      // Airbnb-inspired rules
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
      // Allow console for development
      'no-console': ['warn'],
      // More flexible with underscore dangle
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
];
