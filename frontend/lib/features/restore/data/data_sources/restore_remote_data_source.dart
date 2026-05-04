import 'package:cookify/features/restore/data/requests/restore_request.dart';

abstract interface class RestoreRemoteDataSource {
  Future<void> restore(RestoreRequest request);
}
