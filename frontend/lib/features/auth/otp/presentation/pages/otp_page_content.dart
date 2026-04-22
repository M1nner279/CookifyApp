import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_bottom.dart';
import 'package:cookify/features/auth/auth_common/presentation/widgets/auth_top.dart';
import 'package:cookify/features/auth/otp/presentation/bloc/otp_cubit.dart';
import 'package:cookify/features/auth/otp/presentation/bloc/otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';

class OtpPageContent extends StatefulWidget {
  const OtpPageContent({super.key, required this.nextPage});

  final String nextPage;

  @override
  State<OtpPageContent> createState() => _OtpPageContentState();
}

class _OtpPageContentState extends State<OtpPageContent> {
  final loginController = TextEditingController();

  @override
  void dispose() {
    loginController.dispose();
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
                          child: BlocConsumer<OtpCubit, OtpState>(
                            builder: (context, state) {
                              return Column(
                                spacing: 24.0,
                                children: [
                                  Text(
                                    'Код подтверждения',
                                    style: const TextStyle(
                                      color: Color(0x80FFE6C9),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                      height: 30.0 / 20.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  Column(
                                    spacing: 4.0,
                                    children: [
                                      OtpTextField(
                                        showCursor: false,
                                        numberOfFields: 4,
                                        fieldWidth: 52.0,
                                        fieldHeight: 52.0,
                                        textStyle: const TextStyle(
                                          color: Color(0xFFFFE6C9),
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: -1.2,
                                          height: 36.0 / 30.0,
                                        ),
                                        enabledBorderColor: const Color(
                                          0x0DE5C9A8,
                                        ),
                                        borderColor: const Color(0x0DE5C9A8),
                                        focusedBorderColor: const Color(
                                          0x80FFE6C9,
                                        ),
                                        onSubmit: (String verificationCode) {
                                          context.read<OtpCubit>().confirmCode(
                                            verificationCode,
                                          );
                                        },
                                        showFieldAsBox: true,
                                        autoFocus: true,
                                        filled: true,
                                        fillColor: const Color(0x1AE5C9A8),
                                        onCodeChanged: (_) {
                                          context.read<OtpCubit>().resetState();
                                        },
                                        borderRadius: BorderRadius.circular(
                                          16.0,
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]'),
                                          ),
                                        ],
                                        contentPadding: const EdgeInsets.all(0.0),
                                      ),

                                      if (state is OtpError)
                                        Text(
                                          'Неверный код',
                                          style: const TextStyle(
                                            color: Color(0xFF83260E),
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.0,
                                            height: 20.0 / 14.0,
                                          ),
                                        ),
                                    ],
                                  ),

                                  GestureDetector(
                                    onTap:
                                        state is! OtpLoading &&
                                            context
                                                .read<OtpCubit>()
                                                .canResendCode
                                        ? () {
                                            context
                                                .read<OtpCubit>()
                                                .resendCode();
                                          }
                                        : null,
                                    behavior: HitTestBehavior.opaque,
                                    child: Text(
                                      'Отправить повторно${context.read<OtpCubit>().canResendCode ? '' : ' через ${context.read<OtpCubit>().remainingSeconds} секунд'}',
                                      style: const TextStyle(
                                        color: Color(0x80FFE6C9),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.0,
                                        height: 20.0 / 14.0,
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () => context.go('/auth'),
                                    behavior: HitTestBehavior.opaque,
                                    child: Text(
                                      'Сменить аккаунт',
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
                            listener: (BuildContext context, OtpState state) {
                              if (state is OtpSuccess) {
                                context.go(widget.nextPage);
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
