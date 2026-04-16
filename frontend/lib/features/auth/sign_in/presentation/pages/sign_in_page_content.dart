import 'package:cookify/features/auth/auth_common/domain/exceptions/login_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/password_exception.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_button.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_divider.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_service_button.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_text_field.dart';
import 'package:cookify/features/auth/sign_in/presentation/bloc/sign_in_cubit.dart';
import 'package:cookify/features/auth/sign_in/presentation/bloc/sign_in_state.dart';
import 'package:cookify/features/auth/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPageContent extends StatefulWidget {
  const SignInPageContent({super.key});

  @override
  State<SignInPageContent> createState() => _SignInPageContentState();
}

class _SignInPageContentState extends State<SignInPageContent> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
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
                      context.read<SignInCubit>().validateLogin(value),
                  label: 'ЛОГИН',
                  hint: 'Введите логин',
                  isPassword: false,
                  failureMessage:
                      state is SignInError && state.loginException != null
                      ? switch (state.loginException!) {
                          EmptyLoginException() => 'Поле не может быть пустым',
                          _ => throw UnimplementedError(),
                        }
                      : state is SignInError && state.signInException != null
                      ? 'Неверный логин'
                      : null,
                ),

                AuthTextField(
                  controller: passwordController,
                  onChanged: (value) {
                    context.read<SignInCubit>().validatePassword(value);
                  },
                  inputType: TextInputType.visiblePassword,
                  label: 'ПАРОЛЬ',
                  hint: 'Введите пароль',
                  isPassword: true,
                  failureMessage:
                      state is SignInError && state.passwordException != null
                      ? switch (state.passwordException!) {
                          EmptyPasswordException() =>
                            'Поле не может быть пустым',
                          _ => throw UnimplementedError(),
                        }
                      : state is SignInError && state.signInException != null
                      ? 'Неверный пароль'
                      : null,
                ),

                AuthButton(
                  onPressed: () {
                    context.read<SignInCubit>().signIn(
                      loginController.text,
                      passwordController.text,
                    );
                  },
                  title: 'Войти',
                  isLoading: state is SignInLoading,
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
