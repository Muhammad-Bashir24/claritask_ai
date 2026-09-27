import 'package:equatable/equatable.dart';
import '../../domain/entities/task_step.dart';

abstract class TaskBreakdownState extends Equatable {
  const TaskBreakdownState();

  @override
  List<Object?> get props => [];
}

class TaskBreakdownInitial extends TaskBreakdownState {}

class TaskBreakdownLoading extends TaskBreakdownState {}

class TaskBreakdownSuccess extends TaskBreakdownState {
  final List<TaskStep> steps;

  const TaskBreakdownSuccess(this.steps);

  @override
  List<Object?> get props => [steps];
}

class TaskBreakdownError extends TaskBreakdownState {
  final String message;

  const TaskBreakdownError(this.message);

  @override
  List<Object?> get props => [message];
}
