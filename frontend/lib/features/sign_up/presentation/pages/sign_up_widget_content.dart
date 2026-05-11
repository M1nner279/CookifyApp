import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/core/presentation/widgets/app.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_button.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_divider.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_service_button.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_text_field.dart';
import 'package:cookify/features/sign_up/domain/failures/sign_up_failures.dart';
import 'package:cookify/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:cookify/features/sign_up/presentation/bloc/sign_up_event.dart';
import 'package:cookify/features/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpWidgetContent extends StatefulWidget {
  const SignUpWidgetContent({super.key});

  @override
  State<SignUpWidgetContent> createState() => _SignUpWidgetContentState();
}

class _SignUpWidgetContentState extends State<SignUpWidgetContent> {
  final loginController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  void dispose() {
    fToast = null;
    loginController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Column(
          spacing: 40.0,
          children: [
            Column(
              spacing: 24.0,
              children: [
                AuthTextField(
                  controller: loginController,
                  onChanged: (value) => context.read<SignUpBloc>().add(
                    ValidateLogin(login: value),
                  ),
                  label: MyLocale.of(context).authLoginLabel,
                  hint: MyLocale.of(context).authLoginHint,
                  isPassword: false,
                  failureMessage:
                      state.login.localizeError?.call(context) ??
                      (state.failure != null &&
                              state.failure is LoginAlreadyExistsFailure
                          ? MyLocale.of(context).authSignUpLoginTaken
                          : null),
                ),

                AuthTextField(
                  controller: emailController,
                  onChanged: (value) => context.read<SignUpBloc>().add(
                    ValidateEmail(email: value),
                  ),
                  inputType: TextInputType.emailAddress,
                  label: 'EMAIL',
                  hint: MyLocale.of(context).authEmailHint,
                  isPassword: false,
                  failureMessage:
                      state.email.localizeError?.call(context) ??
                      (state.failure != null &&
                              state.failure is EmailAlreadyExistsFailure
                          ? MyLocale.of(context).authSignUpEmailTaken
                          : null),
                ),

                AuthTextField(
                  controller: passwordController,
                  onChanged: (value) {
                    context.read<SignUpBloc>().add(
                      ValidatePassword(password: value),
                    );
                    context.read<SignUpBloc>().add(
                      ValidateConfirmPassword(
                        confirmPassword: confirmPasswordController.text,
                      ),
                    );
                  },
                  inputType: TextInputType.visiblePassword,
                  label: MyLocale.of(context).authPasswordLabel,
                  hint: MyLocale.of(context).authPasswordHint,
                  isPassword: true,
                  failureMessage: state.password.localizeError?.call(context),
                ),

                AuthTextField(
                  controller: confirmPasswordController,
                  onChanged: (value) => context.read<SignUpBloc>().add(
                    ValidateConfirmPassword(confirmPassword: value),
                  ),
                  inputType: TextInputType.visiblePassword,
                  label: MyLocale.of(context).authConfirmPasswordLabel,
                  hint: MyLocale.of(context).authConfirmPasswordHint,
                  isPassword: true,
                  failureMessage: state.confirmPassword.localizeError?.call(
                    context,
                  ),
                ),

                AuthButton(
                  onPressed: () {
                    context.read<SignUpBloc>().add(SignUp());
                  },
                  title: MyLocale.of(context).authSignUpButton,
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
                    onPressed: () {
                      context.read<SignUpBloc>().add(SignUpWithGoogle());
                    },
                    imagePath: 'google',
                  ),
                ),
              ],
            ),
          ],
        );
      },
      listener: (context, state) {},
    );
  }
}
