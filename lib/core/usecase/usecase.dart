import 'package:fpdart/fpdart.dart';
import 'package:task_management_app/core/error/failure.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

abstract interface class UsecaseForStream<SuccessType, Params> {
  Stream<Either<Failure, SuccessType>> call(Params params);
}

final class NoParams {}
