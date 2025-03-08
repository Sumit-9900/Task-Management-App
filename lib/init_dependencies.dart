import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:task_management_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:task_management_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:task_management_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:task_management_app/features/auth/domain/usecases/log_in_user.dart';
import 'package:task_management_app/features/auth/domain/usecases/sign_up_user.dart';
import 'package:task_management_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_management_app/features/task/data/datasources/task_remote_datasource.dart';
import 'package:task_management_app/features/task/data/repositories/task_repository_impl.dart';
import 'package:task_management_app/features/task/domain/repositories/task_repository.dart';
import 'package:task_management_app/features/task/domain/usecases/add_task.dart';
import 'package:task_management_app/features/task/domain/usecases/delete_task.dart';
import 'package:task_management_app/features/task/domain/usecases/edit_task.dart';
import 'package:task_management_app/features/task/domain/usecases/get_all_tasks.dart';
import 'package:task_management_app/features/task/domain/usecases/toggle_status_tasks.dart';
import 'package:task_management_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:task_management_app/features/task/presentation/cubit/priority_cubit.dart';

final getIt = GetIt.instance;

void initDependencies() {
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  getIt.registerLazySingleton(() => firebaseAuth);
  getIt.registerLazySingleton(() => firestore);

  // Datasources
  getIt.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(firebaseAuth: getIt()),
  );
  getIt.registerFactory<TaskRemoteDatasource>(
    () => TaskRemoteDatasourceImpl(firestore: getIt(), firebaseAuth: getIt()),
  );

  // Repositories
  getIt.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDatasource: getIt()),
  );
  getIt.registerFactory<TaskRepository>(
    () => TaskRepositoryImpl(taskRemoteDatasource: getIt()),
  );

  // Usecases
  getIt.registerFactory(() => SignUpUser(getIt()));
  getIt.registerFactory(() => LogInUser(getIt()));
  getIt.registerFactory(() => AddTask(getIt()));
  getIt.registerFactory(() => GetAllTasks(getIt()));
  getIt.registerFactory(() => EditTask(getIt()));
  getIt.registerFactory(() => DeleteTask(getIt()));
  getIt.registerFactory(() => ToggleStatusTasks(getIt()));

  // Bloc
  getIt.registerLazySingleton(
    () => AuthBloc(signUpUser: getIt(), logInUser: getIt()),
  );
  getIt.registerLazySingleton(
    () => TaskBloc(
      addTask: getIt(),
      getAllTasks: getIt(),
      editTask: getIt(),
      deleteTask: getIt(),
      toggleStatusTasks: getIt(),
    ),
  );

  //Cubit
  getIt.registerLazySingleton(() => PriorityCubit());
}
