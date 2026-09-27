import 'package:equatable/equatable.dart';

enum TaskStatus { pending, inProgress, completed }

class Task extends Equatable {
  final String id;
  final String userId;
  final String title;
  final TaskStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Task({
    required this.id,
    required this.userId,
    required this.title,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, userId, title, status, createdAt, updatedAt];
}
