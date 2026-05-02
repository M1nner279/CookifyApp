import 'package:cookify/features/token/di/token_di.dart';
import 'package:cookify/features/token/navigators/token_navigator.dart';
import 'package:cookify/features/token/presentation/bloc/token_bloc.dart';
import 'package:cookify/features/token/presentation/bloc/token_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenWrapper extends StatelessWidget {
  const TokenWrapper({
    super.key,
    required this.tokenNavigator,
    required this.child,
  });

  final TokenNavigator tokenNavigator;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: TokenBloc(
        tokenNavigator: tokenNavigator,
        getTokenStreamUseCase: TokenDi.getTokenStreamUseCase,
      )..add(InitToken()),
      child: child,
    );
  }
}
