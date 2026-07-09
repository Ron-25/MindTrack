import 'package:mind_track/features/analytics/data/datasources/analytics_remote_datasource.dart';
import 'package:mind_track/features/analytics/domain/entities/analytics_snapshot.dart';
import 'package:mind_track/features/analytics/domain/repositories/analytics_repository.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  const AnalyticsRepositoryImpl(this._remoteDataSource);

  final AnalyticsRemoteDataSource _remoteDataSource;

  @override
  Future<AnalyticsSnapshot> fetchSnapshot({int days = 30}) {
    return _remoteDataSource.fetchSnapshot(days: days);
  }
}
