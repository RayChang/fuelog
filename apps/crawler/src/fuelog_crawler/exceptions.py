class FuelogCrawlerError(Exception):
    """Base exception for Fuelog crawler errors."""
    pass


class NetworkError(FuelogCrawlerError):
    """Network-related errors."""
    pass
