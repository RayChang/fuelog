"""
Fuelog Crawler Package

A CLI tool for data crawling, installable via uv tool install.
"""

try:
    from importlib.metadata import version
    __version__ = version("fuelog-crawler")
except ImportError:
    # Fallback for development or when package is not installed
    __version__ = "0.1.0"
