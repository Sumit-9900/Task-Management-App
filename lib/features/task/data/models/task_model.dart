import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management_app/features/task/domain/entities/task.dart';

enum Priority { low, medium, high }

extension PriorityExtension on Priority {
  String toMap() {
    return name;
  }

  static Priority fromMap(String value) {
    return Priority.values.firstWhere(
      (e) => e.name == value,
      orElse: () => Priority.low,
    );
  }
}

class TaskModel {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime dueDate;
  final Priority priority;
  final bool isCompleted;
  TaskModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.isCompleted,
  });

  Task toTask(TaskModel taskmodel) {
    return Task(
      id: taskmodel.id,
      title: taskmodel.title,
      description: taskmodel.description,
      dueDate: taskmodel.dueDate,
      priority: taskmodel.priority,
      isCompleted: taskmodel.isCompleted,
      userId: taskmodel.userId,
    );
  }

  TaskModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    DateTime? dueDate,
    Priority? priority,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'dueDate': Timestamp.fromDate(dueDate),
      'priority': priority.toMap(),
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      dueDate: (map['dueDate'] as Timestamp).toDate() ,
      priority: PriorityExtension.fromMap(map['priority'] as String),
      isCompleted: map['isCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(id: $id, userId: $userId, title: $title, description: $description, dueDate: $dueDate, priority: $priority, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.title == title &&
        other.description == description &&
        other.dueDate == dueDate &&
        other.priority == priority &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        dueDate.hashCode ^
        priority.hashCode ^
        isCompleted.hashCode;
  }
}
