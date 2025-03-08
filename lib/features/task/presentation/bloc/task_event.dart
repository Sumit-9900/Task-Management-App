part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

final class TaskAdded extends TaskEvent {
  final Task task;
  TaskAdded(this.task);
}

final class TaskFetched extends TaskEvent {}

class TaskSorting extends TaskEvent {
  final String sortOption;
  TaskSorting(this.sortOption);
}

final class TaskEdited extends TaskEvent {
  final Task task;
  TaskEdited(this.task);
}

final class TaskDeleted extends TaskEvent {
  final String id;
  TaskDeleted(this.id);
}

final class TaskToggleStatus extends TaskEvent {
  final Task task;
  TaskToggleStatus({required this.task});
}
