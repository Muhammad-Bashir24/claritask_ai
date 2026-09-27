import 'package:claritask_ai/features/tasks/domain/entities/task.dart';
import 'package:equatable/equatable.dart';

abstract class CreateTaskState extends Equatable {
  const CreateTaskState();

  @override
  List<Object?> get props => [];
}

class CreateTaskInitial extends CreateTaskState {}

class CreateTaskLoading extends CreateTaskState {}

class CreateTaskSuccess extends CreateTaskState {
  final Task task;

  const CreateTaskSuccess(this.task);

  @override
  List<Object?> get props => [task];
}

class CreateTaskError extends CreateTaskState {
  final String message;

  const CreateTaskError(this.message);

  @override
  List<Object?> get props => [message];
}
