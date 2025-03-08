import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:task_management_app/core/error/failure.dart';
import 'package:task_management_app/core/usecase/usecase.dart';
import 'package:task_management_app/features/auth/domain/repositories/auth_repository.dart';

class LogInUser implements Usecase<User?, UserLogInParams> {
  final AuthRepository authRepository;
  LogInUser(this.authRepository);

  @override
  Future<Either<Failure, User?>> call(UserLogInParams params) async {
    return await authRepository.logIn(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLogInParams {
  final String email;
  final String password;
  UserLogInParams({required this.email, required this.password});
}
