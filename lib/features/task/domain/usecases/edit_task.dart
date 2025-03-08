import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:task_management_app/core/error/failure.dart';
import 'package:task_management_app/core/usecase/usecase.dart';
import 'package:task_management_app/features/task/domain/entities/task.dart';
import 'package:task_management_app/features/task/domain/repositories/task_repository.dart';

class EditTask implements Usecase<void, Task> {
  final TaskRepository taskRepository;
  EditTask(this.taskRepository);

  @override
  Future<fpdart.Either<Failure, void>> call(Task task) async {
    return await taskRepository.editTask(task);
  }
}
