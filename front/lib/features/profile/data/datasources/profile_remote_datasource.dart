import 'package:dio/dio.dart';
import 'package:mind_track/core/network/api_client.dart';
import 'package:mind_track/features/profile/domain/entities/profile_settings_data.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileSettingsData> fetchProfile();

  Future<ProfileSettingsData> updateProfileName(String name);

  Future<ProfileSettingsData> updatePreferences({
    String? languageCode,
    bool? notificationsEnabled,
  });
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
      return _mapProfile(response.data as Map<String, dynamic>);
    } on DioException catch (error) {
      throw Exception(_extractMessage(error));
    }
  }

  @override
  Future<ProfileSettingsData> updateProfileName(String name) async {
    try {
      final Response<dynamic> response = await _client.dio.patch<dynamic>(
        '/api/v1/users/profile',
        data: <String, dynamic>{'name': name.trim()},
      );
      return _mapProfile(response.data as Map<String, dynamic>);
    } on DioException catch (error) {
      throw Exception(_extractMessage(error));
    }
  }

  @override
  Future<ProfileSettingsData> updatePreferences({
    String? languageCode,
    bool? notificationsEnabled,
  }) async {
    try {
      await _client.dio.patch<dynamic>(
        '/api/v1/users/preferences',
        data: <String, dynamic>{
          ...?languageCode == null
              ? null
              : <String, dynamic>{'language': languageCode},
          ...?notificationsEnabled == null
              ? null
              : <String, dynamic>{'notif_enabled': notificationsEnabled},
        },
      );
      return fetchProfile();
    } on DioException catch (error) {
      throw Exception(_extractMessage(error));
    }
  }

  ProfileSettingsData _mapProfile(Map<String, dynamic> json) {
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
