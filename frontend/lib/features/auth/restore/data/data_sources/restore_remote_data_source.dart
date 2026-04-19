import 'package:cookify/features/auth/restore/data/requests/restore_request.dart';

abstract class RestoreRemoteDataSource {
  Future<void> restore(RestoreRequest request);
}