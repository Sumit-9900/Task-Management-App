import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/features/auth/domain/usecases/log_in_user.dart';
import 'package:task_management_app/features/auth/domain/usecases/sign_up_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUser _signUpUser;
  final LogInUser _logInUser;
  AuthBloc({required SignUpUser signUpUser, required LogInUser logInUser})
    : _signUpUser = signUpUser,
      _logInUser = logInUser,
      super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onSignUpUser);
    on<AuthLogIn>(_onLogInUser);
  }

  void _onSignUpUser(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _signUpUser(
      UserSignUpParams(email: event.email, password: event.password),
    );

    res.fold((l) => emit(AuthFailure(l.message)), (r) => emit(AuthSuccess(r)));
  }

  void _onLogInUser(AuthLogIn event, Emitter<AuthState> emit) async {
    final res = await _logInUser(
      UserLogInParams(email: event.email, password: event.password),
    );

    res.fold((l) => emit(AuthFailure(l.message)), (r) => emit(AuthSuccess(r)));
  }
}
