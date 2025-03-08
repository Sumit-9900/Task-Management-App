import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/features/task/data/models/task_model.dart';

class PriorityCubit extends Cubit<Priority> {
  PriorityCubit() : super(Priority.low);

  void selectPriority(Priority priority) {
    emit(priority);
  }
}
