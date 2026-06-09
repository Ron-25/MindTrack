import 'package:mind_track/features/home/data/datasources/home_remote_datasource.dart';
import 'package:mind_track/features/home/domain/entities/home_dashboard.dart';
import 'package:mind_track/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._remoteDataSource);

  final HomeRemoteDataSource _remoteDataSource;

  @override
  Future<HomeDashboard> fetchDashboard() {
    return _remoteDataSource.fetchDashboard();
  }
}
