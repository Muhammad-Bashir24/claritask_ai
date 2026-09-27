import 'package:equatable/equatable.dart';

class TaskStep extends Equatable {
  final String id;
  final String taskId;
  final String title;
  final String? description;
  final int position;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TaskStep({
    required this.id,
    required this.taskId,
    required this.title,
    this.description,
    required this.position,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  TaskStep copyWith({
    String? id,
    String? taskId,
    String? title,
    String? description,
    int? position,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TaskStep(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      description: description ?? this.description,
      position: position ?? this.position,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    taskId,
    title,
    description,
    position,
    isCompleted,
    createdAt,
    updatedAt,
  ];
}
