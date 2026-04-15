sealed class ConfirmPasswordException implements Exception {}

class EmptyConfirmPasswordException implements ConfirmPasswordException {}

class NotMatchConfirmPasswordException implements ConfirmPasswordException {}
