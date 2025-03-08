import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/core/utils/show_date_picker.dart';
import 'package:task_management_app/core/utils/show_snackbar.dart';
import 'package:task_management_app/core/widgets/loader.dart';
import 'package:task_management_app/features/auth/presentation/widgets/action_button.dart';
import 'package:task_management_app/features/auth/presentation/widgets/input_field.dart';
import 'package:task_management_app/features/task/data/models/task_model.dart';
import 'package:task_management_app/features/task/domain/entities/task.dart';
import 'package:task_management_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:task_management_app/features/task/presentation/cubit/priority_cubit.dart';
import 'package:uuid/uuid.dart';

class AddEditTaskScreen extends StatefulWidget {
  final String text;
  final Task? task;
  const AddEditTaskScreen({super.key, required this.text, required this.task});

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();
  final firebaseAuth = FirebaseAuth.instance;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dueDateController.dispose();
    super.dispose();
  }

  void addButtonPressed(Priority priority) {
    DateTime dueDate = DateTime.parse(dueDateController.text.trim());

    if (formKey.currentState!.validate()) {
      context.read<TaskBloc>().add(
        TaskAdded(
          Task(
            id: const Uuid().v4(),
            title: titleController.text.trim(),
            description: descriptionController.text.trim(),
            dueDate: dueDate,
            priority: priority,
            isCompleted: false,
            userId: firebaseAuth.currentUser!.uid,
          ),
        ),
      );
    }
  }

  void editButtonPressed(Priority priority) {
    DateTime dueDate = DateTime.parse(dueDateController.text.trim());

    if (formKey.currentState!.validate()) {
      context.read<TaskBloc>().add(
        TaskEdited(
          Task(
            id: widget.task!.id,
            title: titleController.text.trim(),
            description: descriptionController.text.trim(),
            dueDate: dueDate,
            priority: priority,
            isCompleted: false,
            userId: firebaseAuth.currentUser!.uid,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.text} Task')),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Text('TITLE'),
                const SizedBox(height: 5.0),
                InputField(
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter Title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                Text('DESCRIPTION'),
                const SizedBox(height: 5.0),
                InputField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter Description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                Text('DUE DATE'),
                const SizedBox(height: 5.0),
                InputField(
                  controller: dueDateController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter Due Date';
                    }
                    return null;
                  },
                  readOnly: true,
                  onTap: () async {
                    final selectedDate = await selectDate(context);

                    if (selectedDate != null) {
                      dueDateController.text =
                          selectedDate.toString().split(' ').first;
                    }
                  },
                ),
                const SizedBox(height: 18),
                Text('PRIORITY'),
                const SizedBox(height: 5.0),
                BlocSelector<PriorityCubit, Priority, Priority>(
                  selector: (state) {
                    return state;
                  },
                  builder: (context, state) {
                    return Row(
                      children: [
                        ChoiceChip(
                          onSelected: (_) {
                            context.read<PriorityCubit>().selectPriority(
                              Priority.low,
                            );
                          },
                          selected: state == Priority.low,
                          label: Text('Low'),
                          selectedColor: Colors.green,
                        ),
                        const SizedBox(width: 5),
                        ChoiceChip(
                          onSelected:
                              (_) => context
                                  .read<PriorityCubit>()
                                  .selectPriority(Priority.medium),
                          selected: state == Priority.medium,
                          label: Text('Medium'),
                          selectedColor: Colors.orange,
                        ),
                        const SizedBox(width: 5),
                        ChoiceChip(
                          onSelected:
                              (_) => context
                                  .read<PriorityCubit>()
                                  .selectPriority(Priority.high),
                          selected: state == Priority.high,
                          label: Text('High'),
                          selectedColor: Colors.red,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocConsumer<TaskBloc, TaskState>(
                      listener: (context, state) {
                        if (state is TaskFailure) {
                          showSnackBar(context, state.error);
                        } else if (state is TaskSuccess) {
                          showSnackBar(
                            context,
                            'Task ${widget.text}ed successfully!',
                            Colors.green,
                          );
                          Navigator.of(context).pop();
                        }
                      },
                      builder: (context, state) {
                        return BlocSelector<PriorityCubit, Priority, Priority>(
                          selector: (selectedPriority) {
                            return selectedPriority;
                          },
                          builder: (context, selectedPriority) {
                            final isLoading = state is TaskLoading;

                            return ActionButton(
                              onPressed:
                                  isLoading
                                      ? null
                                      : () {
                                        widget.text == 'Add'
                                            ? addButtonPressed(selectedPriority)
                                            : editButtonPressed(
                                              selectedPriority,
                                            );
                                      },
                              widget:
                                  isLoading
                                      ? const Loader()
                                      : Text('${widget.text} Task'),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
