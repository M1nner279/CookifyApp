import 'package:cookify/features/auth/otp/di/otp_di.dart';
import 'package:cookify/features/auth/otp/presentation/bloc/otp_cubit.dart';
import 'package:cookify/features/auth/otp/presentation/pages/otp_page_args.dart';
import 'package:cookify/features/auth/otp/presentation/pages/otp_page_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key, required this.args});

  final OtpPageArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OtpCubit>(
      create: (_) => OtpDi.getIt(param1: args.login),
      child: OtpPageContent(nextPage: args.nextPage),
    );
  }
}
