import 'package:cookify/features/auth/auth_common/domain/exceptions/confirm_password_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/password_exception.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_bottom.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_button.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_text_field.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_top.dart';
import 'package:cookify/features/auth/change_password/presentation/bloc/change_password_cubit.dart';
import 'package:cookify/features/auth/change_password/presentation/bloc/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordPageContent extends StatefulWidget {
  const ChangePasswordPageContent({super.key});

  @override
  State<ChangePasswordPageContent> createState() =>
      _ChangePasswordPageContentState();
}

class _ChangePasswordPageContentState extends State<ChangePasswordPageContent> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 48.0,
                      children: [
                        const AuthTop(),

                        Container(
                          padding: const EdgeInsets.all(32.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2C1C16),
                            border: Border.all(color: const Color(0x1AE5C9A8)),
                            borderRadius: BorderRadius.circular(48.0),
                          ),
                          child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                            builder: (context, state) {
                              return Column(
                                spacing: 24.0,
                                children: [
                                  Text(
                                    'Смена пароля',
                                    style: const TextStyle(
                                      color: Color(0x80FFE6C9),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                      height: 30.0 / 20.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  AuthTextField(
                                    controller: passwordController,
                                    onChanged: (value) {
                                      context
                                          .read<ChangePasswordCubit>()
                                          .validatePassword(value);
                                      context
                                          .read<ChangePasswordCubit>()
                                          .validateConfirmPassword(
                                            value,
                                            confirmPasswordController.text,
                                          );
                                    },
                                    inputType: TextInputType.visiblePassword,
                                    label: 'НОВЫЙ ПАРОЛЬ',
                                    hint: 'Введите новый пароль',
                                    isPassword: true,
                                    failureMessage:
                                        state is ChangePasswordError &&
                                            state.passwordException != null
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
                                        .read<ChangePasswordCubit>()
                                        .validateConfirmPassword(
                                          passwordController.text,
                                          value,
                                        ),
                                    inputType: TextInputType.visiblePassword,
                                    label: 'ПОВТОРИТЕ ПАРОЛЬ',
                                    hint: 'Введите пароль повторно',
                                    isPassword: true,
                                    failureMessage:
                                        state is ChangePasswordError &&
                                            state.confirmPasswordException !=
                                                null
                                        ? switch (state
                                              .confirmPasswordException!) {
                                            EmptyConfirmPasswordException() =>
                                              'Поле не может быть пустым',
                                            NotMatchConfirmPasswordException() =>
                                              'Пароли не совпадают',
                                          }
                                        : null,
                                  ),

                                  AuthButton(
                                    onPressed: () {
                                      context
                                          .read<ChangePasswordCubit>()
                                          .changePassword(
                                            passwordController.text,
                                            confirmPasswordController.text,
                                          );
                                    },
                                    title: 'Сменить',
                                    isLoading: state is ChangePasswordLoading,
                                  ),

                                  GestureDetector(
                                    onTap: () => context.go('/auth'),
                                    behavior: HitTestBehavior.opaque,
                                    child: Text(
                                      'Назад',
                                      style: const TextStyle(
                                        color: Color(0x80FFE6C9),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.0,
                                        height: 20.0 / 14.0,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            listener:
                                (
                                  BuildContext context,
                                  ChangePasswordState state,
                                ) {
                                  if (state is ChangePasswordSuccess) {
                                    context.go('/');
                                  }
                                },
                          ),
                        ),

                        const AuthBottom(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
