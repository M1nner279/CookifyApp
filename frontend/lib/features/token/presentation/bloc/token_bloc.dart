import 'dart:async';

import 'package:cookify/features/token/domain/enums/token_status.dart';
import 'package:cookify/features/token/domain/use_cases/get_token_stream_use_case.dart';
import 'package:cookify/features/token/navigators/token_navigator.dart';
import 'package:cookify/features/token/presentation/bloc/token_event.dart';
import 'package:cookify/features/token/presentation/bloc/token_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class TokenBloc extends Bloc<TokenEvent, TokenState> {
  TokenBloc({
    required TokenNavigator tokenNavigator,
    required GetTokenStreamUseCase getTokenStreamUseCase,
  }) : _tokenNavigator = tokenNavigator,
       _getTokenStreamUseCase = getTokenStreamUseCase,
       super(TokenState()) {
    on<InitToken>(_onInitToken);
  }

  TokenNavigator? _tokenNavigator;
  final GetTokenStreamUseCase _getTokenStreamUseCase;
  StreamSubscription? _tokenStreamSubscription;

  FutureOr<void> _onInitToken(InitToken event, Emitter<TokenState> emit) async {
    final result = await _getTokenStreamUseCase();
    if (isClosed) return;

    result.fold((failure) {}, (stream) {
      _tokenStreamSubscription = stream.listen((event) {
        if (event == TokenStatus.invalid) {
          _tokenNavigator?.goAuth();
        }
      });
    });
  }

  @override
  Future<void> close() async {
    _tokenNavigator = null;
    _tokenStreamSubscription?.cancel();
    return super.close();
  }
}
