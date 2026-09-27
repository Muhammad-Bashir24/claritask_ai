import '../../domain/entities/task_step.dart';

class TaskStepModel extends TaskStep {
  const TaskStepModel({
    required super.id,
    required super.taskId,
    required super.title,
    super.description,
    required super.position,
    required super.isCompleted,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TaskStepModel.fromJson(Map<String, dynamic> json) {
    return TaskStepModel(
      id: json['id'] as String,
      taskId: json['task_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      position: json['position'] as int,
      isCompleted: json['is_completed'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_id': taskId,
      'title': title,
      'description': description,
      'position': position,
      'is_completed': isCompleted,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory TaskStepModel.fromEntity(TaskStep entity) {
    return TaskStepModel(
      id: entity.id,
      taskId: entity.taskId,
      title: entity.title,
      description: entity.description,
      position: entity.position,
      isCompleted: entity.isCompleted,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
