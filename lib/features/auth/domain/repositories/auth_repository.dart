import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:task_management_app/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User?>> signUp({
    required String email,
    required String password,
  });

  Future<Either<Failure, User?>> logIn({
    required String email,
    required String password,
  });
}
