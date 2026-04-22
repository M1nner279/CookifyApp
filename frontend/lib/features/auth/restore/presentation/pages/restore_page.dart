import 'package:cookify/features/auth/restore/di/restore_di.dart';
import 'package:cookify/features/auth/restore/presentation/bloc/restore_cubit.dart';
import 'package:cookify/features/auth/restore/presentation/pages/restore_page_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestorePage extends StatelessWidget {
  const RestorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RestoreCubit>(
      create: (_) => RestoreDi.getIt(),
      child: const RestorePageContent(),
    );
  }
}
