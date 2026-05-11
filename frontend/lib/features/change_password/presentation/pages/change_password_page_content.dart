import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_bottom.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_button.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_text_field.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_top.dart';
import 'package:cookify/features/change_password/presentation/bloc/change_password_bloc.dart';
import 'package:cookify/features/change_password/presentation/bloc/change_password_event.dart';
import 'package:cookify/features/change_password/presentation/bloc/change_password_state.dart';
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
                          child:
                              BlocConsumer<
                                ChangePasswordBloc,
                                ChangePasswordState
                              >(
                                builder: (context, state) {
                                  return Column(
                                    spacing: 24.0,
                                    children: [
                                      Text(
                                        MyLocale.of(
                                          context,
                                        ).changePasswordTitle,
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
                                              .read<ChangePasswordBloc>()
                                              .add(
                                                ValidatePassword(
                                                  password: value,
                                                ),
                                              );
                                          context
                                              .read<ChangePasswordBloc>()
                                              .add(
                                                ValidateConfirmPassword(
                                                  confirmPassword:
                                                      confirmPasswordController
                                                          .text,
                                                ),
                                              );
                                        },
                                        inputType:
                                            TextInputType.visiblePassword,
                                        label: MyLocale.of(
                                          context,
                                        ).changePasswordNewPasswordLabel,
                                        hint: MyLocale.of(
                                          context,
                                        ).changePasswordNewPasswordHint,
                                        isPassword: true,
                                        failureMessage: state
                                            .password
                                            .localizeError
                                            ?.call(context),
                                      ),

                                      AuthTextField(
                                        controller: confirmPasswordController,
                                        onChanged: (value) => context
                                            .read<ChangePasswordBloc>()
                                            .add(
                                              ValidateConfirmPassword(
                                                confirmPassword: value,
                                              ),
                                            ),
                                        inputType:
                                            TextInputType.visiblePassword,
                                        label: MyLocale.of(
                                          context,
                                        ).authConfirmPasswordLabel,
                                        hint: MyLocale.of(
                                          context,
                                        ).authConfirmPasswordHint,
                                        isPassword: true,
                                        failureMessage: state
                                            .confirmPassword
                                            .localizeError
                                            ?.call(context),
                                      ),

                                      AuthButton(
                                        onPressed: () {
                                          context
                                              .read<ChangePasswordBloc>()
                                              .add(ChangePassword());
                                        },
                                        title: MyLocale.of(
                                          context,
                                        ).changePasswordSubmit,
                                        isLoading: state.isLoading,
                                      ),

                                      GestureDetector(
                                        onTap: () => context.pop(),
                                        behavior: HitTestBehavior.opaque,
                                        child: Text(
                                          MyLocale.of(context).commonBack,
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
                                    ) {},
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
        backgroundColor: Color(0xFF1A0F0A),
      ),
    );
  }
}
