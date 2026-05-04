import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/restore/domain/payloads/restore_payload.dart';

abstract interface class RestoreRepository {
  Future<MyEither<void>> restore(RestorePayload payload);
}
