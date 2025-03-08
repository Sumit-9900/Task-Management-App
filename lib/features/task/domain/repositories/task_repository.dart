import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:task_management_app/core/error/failure.dart';
import 'package:task_management_app/features/task/domain/entities/task.dart';

abstract interface class TaskRepository {
  Future<fpdart.Either<Failure, void>> addTask(Task task);
  Stream<fpdart.Either<Failure, List<Task>>> getAllTasks();
  Future<fpdart.Either<Failure, void>> editTask(Task task);
  Future<fpdart.Either<Failure, void>> deleteTask(String id);
  Future<fpdart.Either<Failure, void>> toggleStatus(Task task);
}
