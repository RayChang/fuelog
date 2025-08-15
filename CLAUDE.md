# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Core Commands

- `pnpm dev` - Start development servers for all apps
- `pnpm build` - Build all apps and packages
- `pnpm lint` - Run ESLint across all workspaces
- `pnpm format` - Format code with Prettier
- `pnpm check-types` - Run TypeScript type checking

### Database Commands

- `pnpm db:pull` - Pull database schema from PostgreSQL
- `pnpm db:generate` - Generate Prisma client from schema
- `pnpm db:migrate` - Run database migrations in development
- `pnpm db:studio` - Open Prisma Studio for database management

### Python Commands

- `pnpm python:sync` - Install Python dependencies with uv
- `pnpm python:lint` - Run Python linting with Ruff
- `pnpm python:type-check` - Run Python type checking with MyPy
- `pnpm python:test` - Run Python tests with pytest
- `pnpm python:run` - Run the Python crawler CLI

### Per-app Commands

- `pnpm --filter web dev` - Start only web app (port 3030)
- `pnpm --filter crawler python:sync` - Install crawler dependencies only
- `pnpm --filter @repo/ui lint` - Lint UI package only
- `pnpm --filter @repo/db db:studio` - Open database studio

## Architecture

This is a Turborepo monorepo for Fuelog, a fuel tracking application with both web and Python components.

### Workspace Structure

- **apps/web** - Main Next.js application (port 3030) with Tailwind CSS
- **apps/crawler** - Python CLI tool for fuel price data crawling
- **packages/ui** - Shared React component library (Button, Card, Code)
- **packages/db** - Prisma database package with PostgreSQL schema
- **packages/eslint-config** - Shared ESLint configurations
- **packages/typescript-config** - Shared TypeScript configurations

### Key Technologies

- **Turborepo** for monorepo build orchestration with Python task support
- **pnpm** as package manager with workspaces
- **Next.js 15.4.5** with App Router and Turbopack
- **React 19.1.0** and TypeScript 5.8.x
- **Tailwind CSS 4.x** for styling
- **Prisma 6.13.0** with PostgreSQL for database management
- **Python 3.13+** with uv for dependency management
- **Typer** for Python CLI framework

### Database Schema

Multi-tenant PostgreSQL database supporting:

- User management with tenant isolation
- Vehicle tracking (brands, models, ownership)
- Fuel records with mileage tracking
- Gas station and fuel price data
- Taiwan fuel brand codes (CPC, FORMOSA, NPC, TAYA, FUMAO)

### Python Crawler

Modern CLI tool built with:

- **httpx** for HTTP requests
- **BeautifulSoup4** for HTML parsing
- **Pydantic** for configuration and validation
- **Ruff** for linting and formatting
- **MyPy** for type checking
- **pytest** for testing

### Package Dependencies

- Web app consumes `@repo/ui` and `@repo/db` via workspace protocol
- Database package generates Prisma client to `generated/prisma/`
- Shared configs used via `@repo/eslint-config` and `@repo/typescript-config`
- Python crawler is isolated with uv virtual environment management

## Git Hooks

This project uses Husky for Git hooks to ensure code quality and consistent commit messages.

### Pre-commit Hooks

Automatically run on every commit:

- **Prettier formatting** for TypeScript, JavaScript, Markdown, and JSON files
- **ESLint checking** for TypeScript and JavaScript files
- **Ruff formatting and linting** for Python files in the crawler app
- **TypeScript type checking** when TS files are modified

### Commit Message Validation

Commit messages must follow [Conventional Commits](https://www.conventionalcommits.org/) format:

- `feat(scope): description` - New features
- `fix(scope): description` - Bug fixes
- `docs(scope): description` - Documentation changes
- `style(scope): description` - Code style changes
- `refactor(scope): description` - Code refactoring
- `test(scope): description` - Test changes
- `chore(scope): description` - Build/tooling changes

Valid scopes: `web`, `crawler`, `ui`, `db`, `config`, `deps`, `docs`, `ci`, `release`

### Bypassing Hooks

In emergency situations, you can bypass hooks with:

```bash
git commit --no-verify -m "emergency fix"
```

### Setup

Git hooks are automatically installed when running `pnpm install` via the prepare script.
