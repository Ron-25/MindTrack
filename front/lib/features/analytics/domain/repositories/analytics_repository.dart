import 'package:mind_track/features/analytics/domain/entities/analytics_snapshot.dart';

abstract class AnalyticsRepository {
  Future<AnalyticsSnapshot> fetchSnapshot({int days = 30});
}
