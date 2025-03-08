import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:task_management_app/core/error/failure.dart';
import 'package:task_management_app/core/usecase/usecase.dart';
import 'package:task_management_app/features/auth/domain/repositories/auth_repository.dart';

class SignUpUser implements Usecase<User?, UserSignUpParams> {
  final AuthRepository authRepository;
  SignUpUser(this.authRepository);

  @override
  Future<Either<Failure, User?>> call(UserSignUpParams params) async {
    return await authRepository.signUp(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  UserSignUpParams({required this.email, required this.password});
}
