import 'package:cookify/feature/auth/presentation/bloc/login_cubit.dart';
import 'package:cookify/feature/auth/presentation/bloc/login_state.dart';
import 'package:cookify/feature/auth/presentation/widget/auth_bottom.dart';
import 'package:cookify/feature/auth/presentation/widget/auth_top.dart';
import 'package:cookify/feature/auth/presentation/widget/recover_password_content.dart';
import 'package:cookify/shared/presentation/widget/cookify_loading_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  static const route = '/recover';

  static String fullRoute() => route;

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoginInitial) {
            SchedulerBinding.instance.addPostFrameCallback(
              (_) => context.read<LoginCubit>().authorize(),
            );

            return const CookifyLoadingContent();
          } else if (state is LoginLoading) {
            return const CookifyLoadingContent();
          } else if (state is LoginUnauthorized) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      spacing: 24.0,
                      children: [
                        AuthTop(),

                        RecoverPasswordContent(),

                        AuthBottom(),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is LoginAuthorized) {}

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
