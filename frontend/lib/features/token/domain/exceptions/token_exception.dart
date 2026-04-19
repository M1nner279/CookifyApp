sealed class TokenException implements Exception {}

class ExpiredRefreshTokenException extends TokenException {}
