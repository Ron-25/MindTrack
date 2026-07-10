import 'package:dio/dio.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/core/network/api_client.dart';
import 'package:mind_track/features/profile/domain/entities/profile_settings_data.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileSettingsData> fetchProfile();

  Future<ProfileSettingsData> updateProfileName(String name);

  Future<ProfileSettingsData> updatePreferences({
    String? languageCode,
    bool? notificationsEnabled,
    String? notificationTime,
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
    String? notificationTime,
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
          ...?notificationTime == null
              ? null
              : <String, dynamic>{'notif_time': notificationTime},
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
      notificationTime: _normalizeTime(preferences?['notif_time'] as String?),
    );
  }

  /// El backend envía "HH:MM:SS"; en la app se usa "HH:MM".
  String? _normalizeTime(String? raw) {
    if (raw == null || raw.isEmpty) {
      return null;
    }
    final List<String> parts = raw.split(':');
    if (parts.length < 2) {
      return raw;
    }
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }

  String _extractMessage(DioException error) {
    final dynamic data = error.response?.data;
    if (data is Map<String, dynamic>) {
      return (data['detail'] as String?) ?? S.current.err_load_profile;
    }
    if (error.type == DioExceptionType.connectionError) {
      return S.current.err_connection;
    }
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return S.current.err_timeout;
    }
    return S.current.err_load_profile;
  }
}
