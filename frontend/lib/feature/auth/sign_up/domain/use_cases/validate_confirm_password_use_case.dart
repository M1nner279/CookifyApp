class ValidateConfirmPasswordUseCase {
  bool call(String password, String confirmPassword) => password == confirmPassword;
}