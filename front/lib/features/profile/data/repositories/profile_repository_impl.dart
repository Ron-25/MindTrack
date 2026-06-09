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
}
