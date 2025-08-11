# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

- `pnpm dev` - Start development servers for all apps
- `pnpm build` - Build all apps and packages  
- `pnpm lint` - Run ESLint across all workspaces
- `pnpm format` - Format code with Prettier
- `pnpm check-types` - Run TypeScript type checking

### Per-app commands
- `pnpm --filter web dev` - Start only web app (port 3000)
- `pnpm --filter docs dev` - Start only docs app  
- `pnpm --filter @repo/ui lint` - Lint UI package only

## Architecture

This is a Turborepo monorepo with multiple Next.js apps sharing common packages.

### Workspace Structure
- **apps/web** - Main Next.js application (port 3000)
- **apps/docs** - Documentation Next.js application
- **packages/ui** - Shared React component library
- **packages/eslint-config** - Shared ESLint configurations
- **packages/typescript-config** - Shared TypeScript configurations

### Key Technologies
- **Turborepo** for monorepo build orchestration
- **pnpm** as package manager with workspaces
- **Next.js 15.4.2** with App Router
- **React 19.1.0** and TypeScript 5.8.x
- **CSS Modules** for styling

### Package Dependencies
- Apps consume `@repo/ui` components via workspace protocol
- Shared configs are used via `@repo/eslint-config` and `@repo/typescript-config`
- UI package exports components from `./src/*.tsx` pattern

### Component Library
The `@repo/ui` package provides shared components (Button, Card, Code) that are imported by apps using the pattern `@repo/ui/[component-name]`.