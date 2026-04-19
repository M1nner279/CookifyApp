import 'package:cookify/features/auth/auth_common/domain/exceptions/login_exception.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_button.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_divider.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_service_button.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_text_field.dart';
import 'package:cookify/features/auth/otp/presentation/pages/otp_page_args.dart';
import 'package:cookify/features/auth/restore/presentation/bloc/restore_cubit.dart';
import 'package:cookify/features/auth/restore/presentation/bloc/restore_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RestorePageContent extends StatefulWidget {
  const RestorePageContent({super.key});

  @override
  State<RestorePageContent> createState() => _RestorePageContentState();
}

class _RestorePageContentState extends State<RestorePageContent> {
  final loginController = TextEditingController();

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestoreCubit, RestoreState>(
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
                      context.read<RestoreCubit>().validateLogin(value),
                  label: 'ЛОГИН ИЛИ EMAIL',
                  hint: 'Введите логин или email',
                  isPassword: false,
                  failureMessage:
                      state is RestoreError && state.loginException != null
                      ? switch (state.loginException!) {
                          EmptyLoginException() => 'Поле не может быть пустым',
                          _ => throw UnimplementedError(),
                        }
                      : state is RestoreError && state.restoreException != null
                      ? 'Пользователь с таким логином или email не найден'
                      : null,
                ),

                AuthButton(
                  onPressed: () {
                    context.read<RestoreCubit>().restore(loginController.text);
                  },
                  title: 'Восстановить',
                  isLoading: state is RestoreLoading,
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
        if (state is RestoreSuccess) {
          context.go(
            '/otp',
            extra: OtpPageArgs(
              login: loginController.text,
              nextPage: '/change-password',
            ),
          );
        }
      },
    );
  }
}
