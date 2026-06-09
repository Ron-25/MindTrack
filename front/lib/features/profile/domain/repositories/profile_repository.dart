import 'package:mind_track/features/profile/domain/entities/profile_settings_data.dart';

abstract class ProfileRepository {
  Future<ProfileSettingsData> fetchProfile();
}
