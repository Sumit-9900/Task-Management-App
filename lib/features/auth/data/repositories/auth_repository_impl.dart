import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:task_management_app/core/error/failure.dart';
import 'package:task_management_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:task_management_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, User?>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDatasource.logIn(
        email: email,
        password: password,
      );

      return right(user);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDatasource.signUp(
        email: email,
        password: password,
      );

      return right(user);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
