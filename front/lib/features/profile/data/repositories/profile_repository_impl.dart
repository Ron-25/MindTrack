import 'package:mind_track/app/injector.dart';
import 'package:mind_track/core/services/reminder_service.dart';
import 'package:mind_track/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:mind_track/features/profile/domain/entities/profile_settings_data.dart';
import 'package:mind_track/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._remoteDataSource);

  final ProfileRemoteDataSource _remoteDataSource;

  @override
  Future<ProfileSettingsData> fetchProfile() async {
    final ProfileSettingsData profile = await _remoteDataSource.fetchProfile();
    await _syncReminder(profile);
    return profile;
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
  }) async {
    final ProfileSettingsData profile = await _remoteDataSource
        .updatePreferences(
          languageCode: languageCode,
          notificationsEnabled: notificationsEnabled,
          notificationTime: notificationTime,
        );
    await _syncReminder(profile);
    return profile;
  }

  /// Mantiene la notificación local alineada con las preferencias guardadas.
  /// Nunca falla el flujo de perfil por un problema de notificaciones.
  Future<void> _syncReminder(ProfileSettingsData profile) async {
    try {
      await Injector.get<ReminderService>().syncDailyReminder(
        enabled: profile.notificationsEnabled,
        time: profile.notificationTime,
      );
    } catch (_) {
      // Permiso denegado o plataforma sin soporte: la app sigue funcionando.
    }
  }
}
