import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_button.dart';
import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_divider.dart';
import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_service_button.dart';
import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_text_field.dart';
import 'package:cookify/feature/auth/sign_in/presentation/bloc/sign_in_cubit.dart';
import 'package:cookify/feature/auth/sign_in/presentation/bloc/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
                  label: 'ЛОГИН',
                  hint: 'Введите логин',
                  isPassword: false,
                ),

                AuthTextField(
                  controller: passwordController,
                  label: 'ПАРОЛЬ',
                  hint: 'Введите пароль',
                  isPassword: true,
                ),

                AuthButton(
                  onPressed: () {
                    context.read<SignInCubit>().signIn(
                      loginController.text,
                      passwordController.text,
                    );
                  },
                  title: 'Войти',
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
        if (state is SignInSuccess) {
          context.go('/');
        }
        if (state is SignInError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Не удалось войти. Проверьте логин и пароль'),
            ),
          );
        }
      },
    );
  }
}
