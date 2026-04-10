import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_bottom.dart';
import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_button.dart';
import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_top.dart';
import 'package:cookify/feature/auth/change_password/presentation/bloc/change_password_cubit.dart';
import 'package:cookify/feature/auth/change_password/presentation/bloc/change_password_state.dart';
import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_text_field.dart';
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
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          borderRadius: BorderRadius.circular(48.0),
                        ),
                        child:
                            BlocConsumer<
                              ChangePasswordCubit,
                              ChangePasswordState
                            >(
                              listener: (context, state) {
                                if (state is ChangePasswordSuccess) {
                                  context.go('/');
                                }
                              },
                              builder: (context, state) {
                                final hasPasswordError =
                                    state is ChangePasswordError &&
                                    state.hasPasswordError;
                                final hasConfirmPasswordError =
                                    state is ChangePasswordError &&
                                    state.hasConfirmPasswordError;

                                return Column(
                                  children: [
                                    AuthTextField(
                                      controller: _passwordController,
                                      label: 'НОВЫЙ ПАРОЛЬ',
                                      hint: 'Введите новый пароль',
                                      isPassword: true,
                                      failureMessage: hasPasswordError
                                          ? 'Invalid password format'
                                          : null,
                                    ),
                                    const SizedBox(height: 16),
                                    AuthTextField(
                                      controller: _confirmPasswordController,
                                      label: 'ПОВТОРИТЕ ПАРОЛЬ',
                                      hint: 'Введите пароль повторно',
                                      isPassword: true,
                                      failureMessage: hasConfirmPasswordError
                                          ? 'Passwords do not match'
                                          : null,
                                    ),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      width: double.infinity,
                                      child: AuthButton(
                                        onPressed: () {
                                          context
                                              .read<ChangePasswordCubit>()
                                              .changePassword(
                                                _passwordController.text,
                                                _confirmPasswordController.text,
                                              );
                                        },
                                        title: 'Восстановить',
                                        isLoading:
                                            state is ChangePasswordLoading,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    GestureDetector(
                                      onTap: context.pop,
                                      behavior: HitTestBehavior.opaque,
                                      child: Text(
                                        'Назад',
                                        style: const TextStyle(
                                          color: Color(0xFFFFE6C9),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.4,
                                          height: 24.0 / 16.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
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
      backgroundColor: Color(0xFF1E100A),
    );
  }
}
