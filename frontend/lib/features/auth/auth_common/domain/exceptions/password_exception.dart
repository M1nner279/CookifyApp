sealed class PasswordException implements Exception {}

class EmptyPasswordException implements PasswordException {}

class TooShortPasswordException implements PasswordException {}

class InvalidPasswordException implements PasswordException {}
