import 'package:mind_track/features/profile/domain/entities/profile_settings_data.dart';

abstract class ProfileRepository {
  Future<ProfileSettingsData> fetchProfile();

  Future<ProfileSettingsData> updateProfileName(String name);

  Future<ProfileSettingsData> updatePreferences({
    String? languageCode,
    bool? notificationsEnabled,
    String? notificationTime,
  });
}
