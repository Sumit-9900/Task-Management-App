import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management_app/features/task/data/models/task_model.dart';

abstract interface class TaskRemoteDatasource {
  Future<void> addTask(TaskModel task);
  Stream<List<TaskModel>> getAllTasks();
  Future<void> editTask(TaskModel task);
  Future<void> deleteTask(String id);
  Future<void> toggleStatus(TaskModel task);
}

class TaskRemoteDatasourceImpl implements TaskRemoteDatasource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  const TaskRemoteDatasourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });

  @override
  Future<void> addTask(TaskModel task) async {
    try {
      await firestore.collection('tasks').doc(task.id).set(task.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Stream<List<TaskModel>> getAllTasks() {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser != null) {
      final userId = currentUser.uid;
      return firestore
          .collection('tasks')
          .where('userId', isEqualTo: userId)
          .orderBy('dueDate', descending: false)
          .snapshots()
          .map(
            (snapshot) =>
                snapshot.docs
                    .map((doc) => TaskModel.fromMap(doc.data()))
                    .toList(),
          );
    } else {
      throw Exception('User is null');
    }
  }

  @override
  Future<void> editTask(TaskModel task) async {
    try {
      await firestore
          .collection('tasks')
          .doc(task.id)
          .set(task.toMap(), SetOptions(merge: true));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await firestore.collection('tasks').doc(id).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> toggleStatus(TaskModel task) async {
    try {
      await firestore
          .collection('tasks')
          .doc(task.id)
          .update(task.copyWith(isCompleted: task.isCompleted).toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
