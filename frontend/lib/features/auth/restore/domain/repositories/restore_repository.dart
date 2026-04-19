import 'package:cookify/features/auth/restore/domain/payloads/restore_payload.dart';

abstract interface class RestoreRepository {
  Future<void> restore(RestorePayload payload);
}
