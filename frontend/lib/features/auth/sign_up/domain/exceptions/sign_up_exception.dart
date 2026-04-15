sealed class SignUpException implements Exception {}

class LoginAlreadyExistsException extends SignUpException {}

class EmailAlreadyExistsException extends SignUpException {}

class LoginAndEmailAlreadyExistsException extends SignUpException {}
