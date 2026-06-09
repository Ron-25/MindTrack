import 'package:dio/dio.dart';
import 'package:mind_track/core/network/api_client.dart';
import 'package:mind_track/features/profile/domain/entities/profile_settings_data.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileSettingsData> fetchProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  const ProfileRemoteDataSourceImpl(this._client);

  final ApiClient _client;

  @override
  Future<ProfileSettingsData> fetchProfile() async {
    try {
      final Response<dynamic> response = await _client.dio.get<dynamic>(
        '/api/v1/users/profile',
      );
      final Map<String, dynamic> json = response.data as Map<String, dynamic>;
      final Map<String, dynamic>? preferences =
          json['preferences'] as Map<String, dynamic>?;

      return ProfileSettingsData(
        name: (json['name'] as String?)?.trim().isNotEmpty == true
            ? json['name'] as String
            : 'MindTrack User',
        email: (json['email'] as String?) ?? 'user@mindtrack.com',
        avatarUrl: json['avatar_url'] as String?,
        languageCode: preferences?['language'] as String?,
        notificationsEnabled: preferences?['notif_enabled'] as bool? ?? false,
      );
    } on DioException catch (error) {
      throw Exception(_extractMessage(error));
    }
  }

  String _extractMessage(DioException error) {
    final dynamic data = error.response?.data;
    if (data is Map<String, dynamic>) {
      return (data['detail'] as String?) ?? 'Could not load your profile.';
    }
    if (error.type == DioExceptionType.connectionError) {
      return 'Could not connect to the server.';
    }
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return 'The request timed out.';
    }
    return 'Could not load your profile.';
  }
}
