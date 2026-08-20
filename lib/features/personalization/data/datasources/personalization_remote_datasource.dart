import 'package:claritask_ai/core/error/exceptions.dart';
import 'package:claritask_ai/features/personalization/data/models/personalization_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

abstract interface class PersonalizationRemoteDataSource {
  Future<void> savePersonalization(PersonalizationModel model);
  Future<bool> checkOnboardingCompleted();
  Future<PersonalizationModel?> getPersonalization();
}

class PersonalizationRemoteDataSourceImpl
    implements PersonalizationRemoteDataSource {
  final supabase.SupabaseClient _client;

  PersonalizationRemoteDataSourceImpl(this._client);

  @override
  Future<void> savePersonalization(PersonalizationModel model) async {
    try {
      await _client.functions.invoke(
        'save-personalization',
        body: model.toJson(),
      );
    } on supabase.FunctionException catch (e) {
      throw ServerException(e.details.toString());
    } catch (_) {
      throw ServerException('Failed to save personalization.');
    }
  }

  @override
  Future<bool> checkOnboardingCompleted() async {
    final user = _client.auth.currentUser;
    if (user == null) {
      return false; // Not authenticated, can't check
    }

    try {
      final response = await _client
          .from('profiles')
          .select('onboarding_completed')
          .eq('id', user.id)
          .single();

      return response['onboarding_completed'] as bool? ?? false;
    } catch (_) {
      throw ServerException('Failed to check onboarding status.');
    }
  }

  @override
  Future<PersonalizationModel?> getPersonalization() async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw ServerException('User not authenticated.');
    }

    try {
      final response = await _client
          .from('user_personalization')
          .select()
          .eq('user_id', user.id)
          .maybeSingle();

      if (response == null) {
        return null;
      }

      return PersonalizationModel.fromJson(response);
    } catch (_) {
      throw ServerException('Failed to fetch personalization.');
    }
  }
}
