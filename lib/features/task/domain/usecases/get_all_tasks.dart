import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:task_management_app/core/error/failure.dart';
import 'package:task_management_app/core/usecase/usecase.dart';
import 'package:task_management_app/features/task/domain/entities/task.dart';
import 'package:task_management_app/features/task/domain/repositories/task_repository.dart';

class GetAllTasks implements UsecaseForStream<List<Task>, NoParams> {
  final TaskRepository taskRepository;
  GetAllTasks(this.taskRepository);

  @override
  Stream<fpdart.Either<Failure, List<Task>>> call(NoParams params) {
    return taskRepository.getAllTasks();
  }
}
