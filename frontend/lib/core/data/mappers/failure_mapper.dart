import 'package:cookify/core/data/exceptions/exceptions.dart';
import 'package:cookify/core/domain/failures/failures.dart';

abstract class FailureMapper {
  static Failure toFailure(Exception exception) {
    switch (exception) {
      case NetworkException():
        return const NetworkFailure();
      default:
        return const UnknownFailure();
    }
  }
}