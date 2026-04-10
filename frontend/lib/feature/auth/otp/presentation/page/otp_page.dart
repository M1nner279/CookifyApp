import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_bottom.dart';
import 'package:cookify/feature/auth/auth_common/presentation/widgets/auth_top.dart';
import 'package:cookify/feature/auth/otp/presentation/bloc/otp_cubit.dart';
import 'package:cookify/feature/auth/otp/presentation/bloc/otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key, required this.verifyCode, required this.resendCode, this.isPasswordRestore = false});

  final Future<bool> Function(String code) verifyCode;
  final void Function() resendCode;
  final bool isPasswordRestore;

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
                        child: BlocProvider(
                          create: (context) => OtpCubit(
                            verifyCode: verifyCode,
                            resendCode: resendCode,
                          ),
                          child: BlocConsumer<OtpCubit, OtpState>(
                            builder: (context, state) {
                              return Column(
                                spacing: 24.0,
                                children: [
                                  Text(
                                    'Введите код',
                                    style: const TextStyle(
                                      color: Color(0xFFFFE6C9),
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -1.2,
                                      height: 36.0 / 30.0,
                                    ),
                                  ),

                                  OtpTextField(
                                    numberOfFields: 4,
                                    fieldWidth: 60,
                                    fieldHeight: 60,
                                    filled: true,
                                    fillColor: const Color(0xFFFFE6C9),
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderColor: Colors.transparent,
                                    enabledBorderColor: Colors.transparent,
                                    focusedBorderColor: Color(0xFF1E100A),
                                    showFieldAsBox: true,
                                    textStyle: const TextStyle(
                                      color: Color(0xFF2C1C16),
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -1.2,
                                      height: 36.0 / 30.0,
                                    ),
                                    onSubmit: (String verificationCode) {
                                      context.read<OtpCubit>().verifyCode(
                                        verificationCode,
                                      );
                                    }, // end onSubmit
                                  ),

                                  GestureDetector(
                                    onTap: state is! OtpLoading
                                        ? () {
                                            context
                                                .read<OtpCubit>()
                                                .resendCode();
                                          }
                                        : null,
                                    behavior: HitTestBehavior.opaque,
                                    child: Text(
                                      'Отправить повторно ${(state.isCooldownActive) ? 'через ${state.formattedTime}' : ''}',
                                      style: const TextStyle(
                                        color: Color(0xFFFFE6C9),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.4,
                                        height: 24.0 / 16.0,
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: context.pop,
                                    behavior: HitTestBehavior.opaque,
                                    child: Text(
                                      'Сменить аккаунт',
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
                            }, listener: (BuildContext context, OtpState state) { 
                              if (state is OtpSuccess) {
                                if (isPasswordRestore) {
                                  context.go('/auth/change-password');
                                } else {
                                  context.go('/');
                                }
                              }
                              if (state is OtpError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Неверно введенный код'),
                                  ),
                                );
                              }
                             },
                          ),
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
