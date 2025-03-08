import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:task_management_app/core/error/failure.dart';
import 'package:task_management_app/features/task/data/datasources/task_remote_datasource.dart';
import 'package:task_management_app/features/task/domain/entities/task.dart';
import 'package:task_management_app/features/task/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDatasource taskRemoteDatasource;
  const TaskRepositoryImpl({required this.taskRemoteDatasource});

  @override
  Future<fpdart.Either<Failure, void>> addTask(Task task) async {
    try {
      await taskRemoteDatasource.addTask(task);

      return fpdart.right(null);
    } catch (e) {
      return fpdart.left(Failure(e.toString()));
    }
  }

  @override
  Future<fpdart.Either<Failure, void>> deleteTask(String id) async {
    try {
      await taskRemoteDatasource.deleteTask(id);

      return fpdart.right(null);
    } catch (e) {
      return fpdart.left(Failure(e.toString()));
    }
  }

  @override
  Future<fpdart.Either<Failure, void>> editTask(Task task) async {
    try {
      await taskRemoteDatasource.editTask(task);

      return fpdart.right(null);
    } catch (e) {
      return fpdart.left(Failure(e.toString()));
    }
  }

  @override
  Stream<fpdart.Either<Failure, List<Task>>> getAllTasks() {
    return taskRemoteDatasource
        .getAllTasks()
        .map<fpdart.Either<Failure, List<Task>>>(
          (taskModels) => fpdart.right(
            taskModels.map((taskModel) => taskModel.toTask(taskModel)).toList(),
          ),
        )
        .handleError((e) => fpdart.left(Failure(e.toString())));
  }

  @override
  Future<fpdart.Either<Failure, void>> toggleStatus(Task task) async {
    try {
      await taskRemoteDatasource.toggleStatus(task);

      return fpdart.right(null);
    } catch (e) {
      return fpdart.left(Failure(e.toString()));
    }
  }
}
