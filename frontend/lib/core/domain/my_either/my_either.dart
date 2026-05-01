import 'package:cookify/core/domain/failures/failures.dart';
import 'package:fpdart/fpdart.dart';

typedef MyEither<T> = Either<Failure, T>;