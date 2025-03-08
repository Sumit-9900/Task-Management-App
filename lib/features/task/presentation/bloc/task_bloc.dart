import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/core/usecase/usecase.dart';
import 'package:task_management_app/features/task/data/models/task_model.dart';
import 'package:task_management_app/features/task/domain/entities/task.dart';
import 'package:task_management_app/features/task/domain/usecases/add_task.dart';
import 'package:task_management_app/features/task/domain/usecases/delete_task.dart';
import 'package:task_management_app/features/task/domain/usecases/edit_task.dart';
import 'package:task_management_app/features/task/domain/usecases/get_all_tasks.dart';
import 'package:task_management_app/features/task/domain/usecases/toggle_status_tasks.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  List<Task> _allTasks = [];

  final AddTask _addTask;
  final GetAllTasks _getAllTasks;
  final EditTask _editTask;
  final DeleteTask _deleteTask;
  final ToggleStatusTasks _toggleStatusTasks;
  TaskBloc({
    required AddTask addTask,
    required GetAllTasks getAllTasks,
    required EditTask editTask,
    required DeleteTask deleteTask,
    required ToggleStatusTasks toggleStatusTasks,
  }) : _addTask = addTask,
       _getAllTasks = getAllTasks,
       _editTask = editTask,
       _deleteTask = deleteTask,
       _toggleStatusTasks = toggleStatusTasks,
       super(TaskInitial()) {
    on<TaskAdded>(onTaskAdded);
    on<TaskFetched>(onTaskFetched);
    on<TaskSorting>(onSortTasks);
    on<TaskEdited>(onTaskEdited);
    on<TaskDeleted>(onTaskDeleted);
    on<TaskToggleStatus>(onTaskToggle);
  }

  void onTaskAdded(TaskAdded event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final res = await _addTask(event.task);

    res.fold((l) => emit(TaskFailure(l.message)), (_) {
      emit(TaskSuccess());
      add(TaskFetched());
    });
  }

  void onTaskFetched(TaskFetched event, Emitter<TaskState> emit) async {
    await emit.forEach(
      _getAllTasks(NoParams()),
      onData:
          (data) => data.fold((l) => TaskFailure(l.message), (r) {
            _allTasks = r;
            return TaskSuccessFetched(r, 'Priority');
          }),
      onError: (error, stackTrace) => TaskFailure(error.toString()),
    );
  }

  void onTaskEdited(TaskEdited event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final res = await _editTask(event.task);

    res.fold((l) => emit(TaskFailure(l.message)), (_) {
      emit(TaskSuccess());
      add(TaskFetched());
    });
  }

  void onTaskDeleted(TaskDeleted event, Emitter<TaskState> emit) async {
    final res = await _deleteTask(event.id);

    res.fold((l) => emit(TaskFailure(l.message)), (_) {
      emit(TaskSuccessForDeletion());
      add(TaskFetched());
    });
  }

  void onTaskToggle(TaskToggleStatus event, Emitter<TaskState> emit) async {
    final updatedTask = event.task.copyWith(
      isCompleted: !event.task.isCompleted,
    );

    final res = await _toggleStatusTasks(updatedTask);

    res.fold((l) => emit(TaskFailure(l.message)), (r) => null);
  }

  void onSortTasks(TaskSorting event, Emitter<TaskState> emit) {
    List<Task> sortedTasks = List.from(_allTasks);

    if (event.sortOption == 'Priority') {
      sortedTasks.sort(
        (a, b) =>
            _priorityScore(b.priority).compareTo(_priorityScore(a.priority)),
      );
    } else if (event.sortOption == 'Status') {
      sortedTasks.sort((a, b) => a.isCompleted ? 1 : -1);
    }

    emit(TaskSuccessFetched(sortedTasks, event.sortOption));
  }

  int _priorityScore(Priority priority) {
    if (priority == Priority.high) return 3;
    if (priority == Priority.medium) return 2;
    return 1;
  }
}
