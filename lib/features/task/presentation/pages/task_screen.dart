import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/core/utils/show_snackbar.dart';
import 'package:task_management_app/core/widgets/loader.dart';
import 'package:task_management_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:task_management_app/features/task/presentation/pages/add_edit_task_screen.dart';
import 'package:task_management_app/features/task/presentation/widgets/dropdown.dart';
import 'package:task_management_app/features/task/presentation/widgets/task_card.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks'), actions: [SortDropdown()]),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Loader();
          } else if (state is TaskSuccessFetched) {
            final tasks = state.allTasks;

            return tasks.isEmpty
                ? const Center(
                  child: Text(
                    'No Tasks to Display!!!',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                )
                : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.separated(
                    itemCount: tasks.length,
                    separatorBuilder:
                        (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return TaskCard(task: tasks[index]);
                    },
                  ),
                );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (ctx) => const AddEditTaskScreen(text: 'Add', task: null),
            ),
          );
        },
      ),
    );
  }
}
