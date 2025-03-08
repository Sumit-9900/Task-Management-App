import 'package:fpdart/fpdart.dart';
import 'package:task_management_app/core/error/failure.dart';
import 'package:task_management_app/core/usecase/usecase.dart';
import 'package:task_management_app/features/task/domain/repositories/task_repository.dart';

class DeleteTask implements Usecase<void, String> {
  final TaskRepository taskRepository;
  DeleteTask(this.taskRepository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await taskRepository.deleteTask(id);
  }
}
