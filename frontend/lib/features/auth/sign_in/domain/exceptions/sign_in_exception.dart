sealed class SignInException implements Exception {}

class IncorrectLoginOrPasswordException extends SignInException {}
