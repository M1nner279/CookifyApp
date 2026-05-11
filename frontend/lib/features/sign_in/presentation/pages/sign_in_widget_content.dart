import 'package:cookify/core/presentation/widgets/app.dart';
import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_button.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_divider.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_service_button.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_text_field.dart';
import 'package:cookify/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:cookify/features/sign_in/presentation/bloc/sign_in_event.dart';
import 'package:cookify/features/sign_in/presentation/bloc/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInWidgetContent extends StatefulWidget {
  const SignInWidgetContent({super.key});

  @override
  State<SignInWidgetContent> createState() => _SignInWidgetContentState();
}

class _SignInWidgetContentState extends State<SignInWidgetContent> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    fToast = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
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
                  label: MyLocale.of(context).authLoginLabel,
                  hint: MyLocale.of(context).authLoginHint,
                  isPassword: false,
                  failureMessage:
                      state.login.localizeError?.call(context) ??
                      (state.hasError
                          ? MyLocale.of(context).authSignInWrongLogin
                          : null),
                ),

                AuthTextField(
                  controller: passwordController,
                  onChanged: (value) {
                    context.read<SignInBloc>().add(
                      ValidatePassword(password: value),
                    );
                  },
                  inputType: TextInputType.visiblePassword,
                  label: MyLocale.of(context).authPasswordLabel,
                  hint: MyLocale.of(context).authPasswordHint,
                  isPassword: true,
                  failureMessage:
                      state.password.localizeError?.call(context) ??
                      (state.hasError
                          ? MyLocale.of(context).authSignInWrongPassword
                          : null),
                ),

                AuthButton(
                  onPressed: () {
                    context.read<SignInBloc>().add(SignIn());
                  },
                  title: MyLocale.of(context).authSignInButton,
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
                      context.read<SignInBloc>().add(SignInWithGoogle());
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
