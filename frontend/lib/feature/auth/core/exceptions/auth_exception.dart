class AuthException implements Exception {}

class UserNotFoundException extends AuthException {}

class WrongPasswordException extends AuthException {}
