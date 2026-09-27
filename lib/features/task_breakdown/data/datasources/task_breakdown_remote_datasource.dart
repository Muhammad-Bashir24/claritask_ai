import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../models/task_step_model.dart';

abstract class TaskBreakdownRemoteDataSource {
  Future<List<TaskStepModel>> breakdownTask(String taskId);
  Future<List<TaskStepModel>> getTaskSteps(String taskId);
  Future<void> updateTaskStepCompletion(String stepId, bool isCompleted);
}

@LazySingleton(as: TaskBreakdownRemoteDataSource)
class TaskBreakdownRemoteDataSourceImpl
    implements TaskBreakdownRemoteDataSource {
  final SupabaseClient _supabaseClient;

  TaskBreakdownRemoteDataSourceImpl(this._supabaseClient);

  @override
  Future<List<TaskStepModel>> breakdownTask(String taskId) async {
    try {
      final response = await _supabaseClient.functions.invoke(
        'breakdown-task',
        body: {'task_id': taskId},
      );

      if (response.status != 200) {
        throw ServerException('Failed to breakdown task: ${response.status}');
      }

      final data = response.data;
      if (data == null || data['success'] != true) {
        throw ServerException(
          data?['error'] ?? 'Unknown error occurred during breakdown',
        );
      }

      final stepsJson = data['steps'] as List<dynamic>;
      return stepsJson
          .map((e) => TaskStepModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on FunctionException catch (e) {
      String errorMessage = 'Edge Function error';
      if (e.details is Map) {
        errorMessage = (e.details as Map)['error']?.toString() ?? errorMessage;
      } else if (e.details is String) {
        errorMessage = e.details as String;
      } else if (e.reasonPhrase != null) {
        errorMessage = e.reasonPhrase!;
      }
      throw ServerException(errorMessage);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<TaskStepModel>> getTaskSteps(String taskId) async {
    try {
      final response = await _supabaseClient
          .from('task_steps')
          .select()
          .eq('task_id', taskId)
          .order('position', ascending: true);

      return (response as List<dynamic>)
          .map((e) => TaskStepModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateTaskStepCompletion(String stepId, bool isCompleted) async {
    try {
      await _supabaseClient
          .from('task_steps')
          .update({'is_completed': isCompleted})
          .eq('id', stepId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
