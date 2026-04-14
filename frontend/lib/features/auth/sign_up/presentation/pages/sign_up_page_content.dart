import 'package:cookify/features/auth/auth_common/domain/exceptions/confirm_password_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/email_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/login_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/password_exception.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_button.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_divider.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_service_button.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_text_field.dart';
import 'package:cookify/features/auth/sign_up/domain/exceptions/sign_up_exception.dart';
import 'package:cookify/features/auth/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:cookify/features/auth/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPageContent extends StatefulWidget {
  const SignUpPageContent({super.key});

  @override
  State<SignUpPageContent> createState() => _SignUpPageContentState();
}

class _SignUpPageContentState extends State<SignUpPageContent> {
  final loginController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    loginController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Column(
          spacing: 40.0,
          children: [
            Column(
              spacing: 24.0,
              children: [
                AuthTextField(
                  controller: loginController,
                  onChanged: (value) =>
                      context.read<SignUpCubit>().validateLogin(value),
                  label: 'ЛОГИН',
                  hint: 'Введите логин',
                  isPassword: false,
                  failureMessage:
                      state is SignUpError && state.loginException != null
                      ? switch (state.loginException!) {
                          EmptyLoginException() => 'Поле не может быть пустым',
                          TooShortLoginException() =>
                            'Длина логина минимум 3 символа',
                        }
                      : state is SignUpError &&
                            (state.signUpException
                                    is LoginAlreadyExistsException ||
                                state.signUpException
                                    is LoginAndEmailAlreadyExistsException)
                      ? 'Пользователь с таким логином уже зарегистрирован'
                      : null,
                ),

                AuthTextField(
                  controller: emailController,
                  onChanged: (value) =>
                      context.read<SignUpCubit>().validateEmail(value),
                  inputType: TextInputType.emailAddress,
                  label: 'EMAIL',
                  hint: 'Введите email',
                  isPassword: false,
                  failureMessage:
                      state is SignUpError && state.emailException != null
                      ? switch (state.emailException!) {
                          EmptyEmailException() => 'Поле не может быть пустым',
                          InvalidEmailException() => 'Невалидный email',
                        }
                      : state is SignUpError &&
                            (state.signUpException
                                    is EmailAlreadyExistsException ||
                                state.signUpException
                                    is LoginAndEmailAlreadyExistsException)
                      ? 'Пользователь с таким email уже зарегистрирован'
                      : null,
                ),

                AuthTextField(
                  controller: passwordController,
                  onChanged: (value) {
                    context.read<SignUpCubit>().validatePassword(value);
                    context.read<SignUpCubit>().validateConfirmPassword(
                      value,
                      confirmPasswordController.text,
                    );
                  },
                  inputType: TextInputType.visiblePassword,
                  label: 'ПАРОЛЬ',
                  hint: 'Введите пароль',
                  isPassword: true,
                  failureMessage:
                      state is SignUpError && state.passwordException != null
                      ? switch (state.passwordException!) {
                          EmptyPasswordException() =>
                            'Поле не может быть пустым',
                          TooShortPasswordException() =>
                            'Длина пароля минимум 6 символов',
                          InvalidPasswordException() =>
                            'Пароль должен содержать строчные и заглавные буквы, цифры и специальные символы',
                        }
                      : null,
                ),

                AuthTextField(
                  controller: confirmPasswordController,
                  onChanged: (value) => context
                      .read<SignUpCubit>()
                      .validateConfirmPassword(passwordController.text, value),
                  inputType: TextInputType.visiblePassword,
                  label: 'ПОВТОРИТЕ ПАРОЛЬ',
                  hint: 'Введите пароль повторно',
                  isPassword: true,
                  failureMessage:
                      state is SignUpError &&
                          state.confirmPasswordException != null
                      ? switch (state.confirmPasswordException!) {
                          EmptyConfirmPasswordException() =>
                            'Поле не может быть пустым',
                          NotMatchConfirmPasswordException() =>
                            'Пароли не совпадают',
                        }
                      : null,
                ),

                AuthButton(
                  onPressed: () {
                    context.read<SignUpCubit>().signUp(
                      loginController.text,
                      emailController.text,
                      passwordController.text,
                      confirmPasswordController.text,
                    );
                  },
                  title: 'Зарегистрироваться',
                  isLoading: state is SignUpLoading,
                ),
              ],
            ),

            const AuthDivider(),

            Row(
              spacing: 16.0,
              children: [
                Expanded(
                  child: AuthServiceButton(
                    onPressed: () {},
                    imagePath: 'google',
                  ),
                ),

                Expanded(
                  child: AuthServiceButton(
                    onPressed: () {},
                    imagePath: 'apple',
                  ),
                ),
              ],
            ),
          ],
        );
      },
      listener: (context, state) {
        if (state is SignUpSuccess) {
          // context.push('/auth/otp', extra: {
          //   'verifyCode': context.read<SignUpCubit>().verifyCode,
          //   'resendCode': context.read<SignUpCubit>().resendCode,
          // });
        }
      },
    );
  }
}
