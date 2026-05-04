import 'package:cookify/features/otp/di/otp_di.dart';
import 'package:cookify/features/otp/presentation/bloc/otp_bloc.dart';
import 'package:cookify/features/otp/presentation/pages/otp_page_args.dart';
import 'package:cookify/features/otp/presentation/pages/otp_page_content.dart';
import 'package:cookify/features/token/di/token_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key, required this.args});

  final OtpPageArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OtpBloc>(
      create: (_) => OtpBloc(
        login: args.login,
        confirmCodeUseCase: OtpDi.confirmCodeUseCase,
        resendCodeUseCase: OtpDi.resendCodeUseCase,
        saveTokenUseCase: TokenDi.setTokenUseCase,
      ),
      child: OtpPageContent(nextPage: args.nextPage),
    );
  }
}
