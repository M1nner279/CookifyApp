import 'package:cookify/feature/auth/restore/domain/payloads/resend_restore_payload.dart';
import 'package:cookify/feature/auth/restore/domain/payloads/restore_payload.dart';
import 'package:cookify/feature/auth/restore/domain/payloads/verify_restore_payload.dart';
import 'package:cookify/feature/auth/restore/domain/use_cases/resend_restore_use_case.dart';
import 'package:cookify/feature/auth/restore/domain/use_cases/restore_use_case.dart';
import 'package:cookify/feature/auth/restore/domain/use_cases/verify_restore_use_case.dart';
import 'package:cookify/feature/auth/restore/presentation/bloc/restore_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestoreCubit extends Cubit<RestoreState> {
  RestoreCubit({
    required RestoreUseCase restoreUseCase,
    required VerifyRestoreUseCase verifyRestoreUseCase,
    required ResendRestoreUseCase resendRestoreUseCase,
  }) : _restoreUseCase = restoreUseCase,
       _verifyRestoreUseCase = verifyRestoreUseCase,
       _resendRestoreUseCase = resendRestoreUseCase,
       super(RestoreInitial());

  final RestoreUseCase _restoreUseCase;
  final VerifyRestoreUseCase _verifyRestoreUseCase;
  final ResendRestoreUseCase _resendRestoreUseCase;
  String? _email;

  Future<void> restore(String loginOrEmail) async {
    emit(const RestoreLoading());

    final result = await _restoreUseCase(
      RestorePayload(loginOrEmail: loginOrEmail),
    );

    if (!isClosed) {
      emit(result ? const RestoreSuccess() : const RestoreError());
      _email = loginOrEmail;
    }
  }

  Future<bool> verifyCode(String code) {
    return _verifyRestoreUseCase(
      VerifyRestorePayload(email: _email!, code: code),
    );
  }

  Future<void> resendCode() {
    return _resendRestoreUseCase(ResendRestorePayload(email: _email!));
  }
}
