import 'package:claritask_ai/core/error/exceptions.dart';
import 'package:claritask_ai/features/tasks/data/models/task_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class TaskRemoteDataSource {
  Future<TaskModel> createTask(String title);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final SupabaseClient supabaseClient;

  TaskRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<TaskModel> createTask(String title) async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) {
      throw ServerException('User is not authenticated');
    }

    try {
      final response = await supabaseClient
          .from('tasks')
          .insert({'user_id': user.id, 'title': title, 'status': 'pending'})
          .select()
          .single();

      return TaskModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
