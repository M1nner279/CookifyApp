import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_button.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_divider.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_service_button.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_text_field.dart';
import 'package:cookify/features/restore/presentation/bloc/restore_bloc.dart';
import 'package:cookify/features/restore/presentation/bloc/restore_event.dart';
import 'package:cookify/features/restore/presentation/bloc/restore_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestoreWidgetContent extends StatefulWidget {
  const RestoreWidgetContent({super.key});

  @override
  State<RestoreWidgetContent> createState() => _RestoreWidgetContentState();
}

class _RestoreWidgetContentState extends State<RestoreWidgetContent> {
  final loginController = TextEditingController();

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestoreBloc, RestoreState>(
      builder: (context, state) {
        return Column(
          spacing: 40.0,
          children: [
            Column(
              spacing: 24.0,
              children: [
                AuthTextField(
                  controller: loginController,
                  onChanged: (value) => context.read<RestoreBloc>().add(
                    ValidateLogin(login: value),
                  ),
                  label: 'ЛОГИН ИЛИ EMAIL',
                  hint: 'Введите логин или email',
                  isPassword: false,
                  failureMessage: state.login.localizeError?.call(context),
                ),

                AuthButton(
                  onPressed: () {
                    context.read<RestoreBloc>().add(Restore());
                  },
                  title: 'Восстановить',
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
      listener: (context, state) {},
    );
  }
}
