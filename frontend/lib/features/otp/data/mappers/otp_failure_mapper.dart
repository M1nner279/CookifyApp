import 'package:cookify/core/data/mappers/failure_mapper.dart';
import 'package:cookify/core/domain/failures/failures.dart';
import 'package:cookify/features/otp/data/exceptions/otp_exceptions.dart';
import 'package:cookify/features/otp/domain/failures/otp_failures.dart';

abstract class OtpFailureMapper {
  static Failure toFailure(Exception exception) {
    switch (exception) {
      case InvalidCodeException():
        return const InvalidCodeFailure();
      default:
        return FailureMapper.toFailure(exception);
    }
  }
}
