import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_button.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_divider.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_service_button.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_text_field.dart';
import 'package:cookify/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:cookify/features/sign_in/presentation/bloc/sign_in_event.dart';
import 'package:cookify/features/sign_in/presentation/bloc/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInWidgetContent extends StatefulWidget {
  const SignInWidgetContent({super.key});

  @override
  State<SignInWidgetContent> createState() => _SignInWidgetContentState();
}

class _SignInWidgetContentState extends State<SignInWidgetContent> {
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
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return Column(
          spacing: 40.0,
          children: [
            Column(
              spacing: 24.0,
              children: [
                AuthTextField(
                  controller: loginController,
                  onChanged: (value) => context.read<SignInBloc>().add(
                    ValidateLogin(login: value),
                  ),
                  label: 'ЛОГИН',
                  hint: 'Введите логин',
                  isPassword: false,
                  failureMessage:
                      state.login.localizeError?.call(context) ??
                      (state.hasError ? 'Неправильный логин' : null),
                ),

                AuthTextField(
                  controller: passwordController,
                  onChanged: (value) {
                    context.read<SignInBloc>().add(
                      ValidatePassword(password: value),
                    );
                  },
                  inputType: TextInputType.visiblePassword,
                  label: 'ПАРОЛЬ',
                  hint: 'Введите пароль',
                  isPassword: true,
                  failureMessage:
                      state.password.localizeError?.call(context) ??
                      (state.hasError ? 'Неправильный пароль' : null),
                ),

                AuthButton(
                  onPressed: () {
                    context.read<SignInBloc>().add(SignIn());
                  },
                  title: 'Войти',
                  isLoading: state.isLoading,
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
    );
  }
}
