import 'package:mind_track/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:mind_track/features/profile/domain/entities/profile_settings_data.dart';
import 'package:mind_track/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._remoteDataSource);

  final ProfileRemoteDataSource _remoteDataSource;

  @override
  Future<ProfileSettingsData> fetchProfile() {
    return _remoteDataSource.fetchProfile();
  }

  @override
  Future<ProfileSettingsData> updateProfileName(String name) {
    return _remoteDataSource.updateProfileName(name);
  }

  @override
  Future<ProfileSettingsData> updatePreferences({
    String? languageCode,
    bool? notificationsEnabled,
    String? notificationTime,
  }) {
    return _remoteDataSource.updatePreferences(
      languageCode: languageCode,
      notificationsEnabled: notificationsEnabled,
      notificationTime: notificationTime,
    );
  }
}
