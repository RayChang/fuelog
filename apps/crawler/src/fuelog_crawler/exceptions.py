class FuelogCrawlerError(Exception):
    """Base exception for Fuelog crawler errors."""


class NetworkError(FuelogCrawlerError):
    """Network-related errors."""
