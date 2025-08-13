# Fuelog Crawler

A CLI tool scaffold using standard Python package structure, installable via `uv tool install`.

## 📁 Project Structure

```
apps/crawler/
├── src/
│   └── fuelog_crawler/     # Main package
│       ├── __init__.py     # Package initialization
│       ├── __main__.py     # Support for python -m execution
│       └── cli.py          # CLI main logic
├── tests/
│   └── test_basic.py       # Basic tests
├── pyproject.toml          # Project configuration and dependencies
├── package.json            # npm/turbo script configuration
└── README.md               # Project documentation
```

## 🚀 Quick Start

### Install Dependencies

```bash
# Install dependencies using uv
uv sync
```

### Development Execution

```bash
# Method 1: Using npm scripts
npm run dev

# Method 2: Direct uv usage
uv run python -m fuelog_crawler

# Method 3: Using CLI command
uv run fuelog-crawler
```

### System Installation

```bash
# Install to system (globally available)
uv tool install .

# Use the system-installed command
fuelog-crawler
```

## 🛠️ Development

### Code Quality

```bash
# Lint check
npm run lint

# Auto-fix lint issues
npm run lint:fix

# Type checking
npm run check-types
```

### Testing

```bash
# Run tests
npm run test

# Watch mode testing
npm run test:watch
```

### Build

```bash
# Build package
npm run build
```

## 🏗️ Turbo Integration

This project is integrated into the monorepo's turbo workflow:

```bash
# Execute from root directory
pnpm turbo run python:test --filter=crawler
pnpm turbo run python:lint --filter=crawler
pnpm turbo run python:run --filter=crawler
```

## 📦 Tech Stack

- **Python 3.13+** - Runtime environment
- **uv** - Dependency management and tooling
- **Hatchling** - Modern build backend
- **Ruff** - Fast linting
- **MyPy** - Type checking
- **pytest** - Testing framework

## 🗑️ Uninstall

```bash
uv tool uninstall fuelog-crawler
```

## 💡 Extension Guide

1. **Add new features**: Add new modules in `src/fuelog_crawler/`
2. **Update CLI**: Modify `src/fuelog_crawler/cli.py`
3. **Add tests**: Add test files in the `tests/` directory
4. **Update dependencies**: Modify `dependencies` in `pyproject.toml`

## 📄 License

This project follows the license in the project root directory.
