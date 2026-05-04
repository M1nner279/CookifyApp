import 'package:cookify/core/data/mappers/failure_mapper.dart';
import 'package:cookify/core/domain/failures/failures.dart';
import 'package:cookify/features/restore/data/exceptions/restore_exceptions.dart';
import 'package:cookify/features/restore/domain/failures/restore_failures.dart';

abstract class RestoreFailureMapper {
  static Failure toFailure(Exception exception) {
    switch (exception) {
      case NonExistentLoginOrEmailException():
        return const NonExistentLoginOrEmailFailure();
      default:
        return FailureMapper.toFailure(exception);
    }
  }
}
