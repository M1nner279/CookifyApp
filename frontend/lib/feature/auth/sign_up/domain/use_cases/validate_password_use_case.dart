class ValidatePasswordUseCase {
  bool call(String password) =>
      password.length >= 6 &&
      password.contains(RegExp('[0-9]')) &&
      password.contains(RegExp('[a-z]')) &&
      password.contains(RegExp('[A-Z]')) && 
      password.contains(RegExp(r'[#_@]'));
}
