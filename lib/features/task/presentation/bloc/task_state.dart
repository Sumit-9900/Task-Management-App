part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskFailure extends TaskState {
  final String error;
  TaskFailure(this.error);
}

final class TaskSuccess extends TaskState {}

final class TaskSuccessForDeletion extends TaskState {}

final class TaskSuccessFetched extends TaskState {
  final List<Task> allTasks;
  final String sortOption;
  TaskSuccessFetched(this.allTasks, this.sortOption);
}
