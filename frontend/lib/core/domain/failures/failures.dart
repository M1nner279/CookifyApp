abstract class Failure {
  const Failure();
}

class NetworkFailure implements Failure {
  const NetworkFailure();
}

class UnknownFailure implements Failure {
  const UnknownFailure();
}
