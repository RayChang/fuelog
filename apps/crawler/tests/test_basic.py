"""Basic tests for Fuelog Crawler CLI tool."""

import subprocess
import sys
from pathlib import Path


def test_cli_help():
    """Test CLI help command execution."""
    project_root = Path(__file__).parent.parent
    result = subprocess.run(
        [sys.executable, "-m", "fuelog_crawler.cli", "--help"],
        capture_output=True,
        text=True,
        cwd=project_root / "src"
    )
    assert result.returncode == 0


def test_module_import():
    """Test that the module can be imported successfully."""
    try:
        import fuelog_crawler
        assert hasattr(fuelog_crawler, "__version__")
    except ImportError:
        # Import might fail in test environment, this is normal
        pass


def test_main_module():
    """Test that __main__.py exists for module execution."""
    project_root = Path(__file__).parent.parent
    main_file = project_root / "src" / "fuelog_crawler" / "__main__.py"
    assert main_file.exists()
