class ValidateLoginUseCase {
  bool call(String login) => login.length >= 3;
}