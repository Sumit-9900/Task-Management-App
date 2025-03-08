import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/features/task/presentation/bloc/task_bloc.dart';

class SortDropdown extends StatelessWidget {
  const SortDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        String currentSortOption = 'Priority';
        if (state is TaskSuccessFetched) {
          currentSortOption = state.sortOption;
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentSortOption,
              iconEnabledColor: Colors.black,
              borderRadius: BorderRadius.circular(12),
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              items:
                  ['Priority', 'Status'].map((option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(option),
                      ),
                    );
                  }).toList(),
              onChanged: (value) {
                if (value != null) {
                  context.read<TaskBloc>().add(TaskSorting(value));
                }
              },
            ),
          ),
        );
      },
    );
  }
}
