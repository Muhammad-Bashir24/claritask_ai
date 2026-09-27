import 'package:claritask_ai/features/tasks/domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    TaskStatus parseStatus(String statusStr) {
      switch (statusStr) {
        case 'in_progress':
          return TaskStatus.inProgress;
        case 'completed':
          return TaskStatus.completed;
        case 'pending':
        default:
          return TaskStatus.pending;
      }
    }

    return TaskModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      status: parseStatus(json['status'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    String formatStatus(TaskStatus status) {
      switch (status) {
        case TaskStatus.inProgress:
          return 'in_progress';
        case TaskStatus.completed:
          return 'completed';
        case TaskStatus.pending:
          return 'pending';
      }
    }

    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'status': formatStatus(status),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
