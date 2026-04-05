import 'package:cookify/config/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

Future<Either<Failure, T>> safeRemoteDataSourceCall<T>(
  Future<T> Function() call,
) async {
  try {
    final result = await call();

    return Right(result);
  } on DioException {
    return Left(ServerFailure());
  }
}
