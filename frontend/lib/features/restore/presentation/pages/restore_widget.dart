import 'package:cookify/di/di.dart';
import 'package:cookify/features/restore/di/restore_di.dart';
import 'package:cookify/features/restore/navigators/restore_navigator.dart';
import 'package:cookify/features/restore/presentation/bloc/restore_bloc.dart';
import 'package:cookify/features/restore/presentation/pages/restore_widget_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestoreWidget extends StatelessWidget {
  const RestoreWidget({super.key, required this.restoreNavigator});

  final RestoreNavigator restoreNavigator;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RestoreBloc(
        restoreNavigator: restoreNavigator,
        restoreDependency: Di.restoreDependency,
        restoreUseCase: RestoreDi.restoreUseCase,
      ),
      child: const RestoreWidgetContent(),
    );
  }
}
