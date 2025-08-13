
# Fuelog Crawler

A modern Python CLI tool scaffold using [typer](https://typer.tiangolo.com/) for easy command-line development. Installable via `uv tool install`.


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
# Install all dependencies
uv sync
```



### CLI Usage Examples

After installation, you can use the CLI directly:

```bash
# Run CLI commands
fuelog-crawler hello
fuelog-crawler info

# Or use python -m
python -m fuelog_crawler info
```



### System Installation

```bash
# Install globally
uv tool install .

# Use the installed command
fuelog-crawler hello
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



## 💡 CLI Extension Guide

This tool uses [typer](https://typer.tiangolo.com/) as the CLI framework, making it easy to add new commands:

1. Add a new function in `src/fuelog_crawler/cli.py` and decorate it with `@app.command()`
2. Reinstall/sync dependencies to use the new command

Example:

```python
import typer
app = typer.Typer()

@app.command()
def hello(name: str = "world"):
	print(f"👋 Hello, {name}!")

if __name__ == "__main__":
	app()
```

## Development Workflow

1. **Add new features**: Create new modules in `src/fuelog_crawler/`
2. **Extend CLI**: Edit `src/fuelog_crawler/cli.py`
3. **Write tests**: Add test files in the `tests/` directory
4. **Update dependencies**: Edit `dependencies` in `pyproject.toml`


## 📄 License

This project follows the license in the project root directory.
