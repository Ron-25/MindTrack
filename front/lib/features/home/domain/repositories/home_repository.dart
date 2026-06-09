import 'package:mind_track/features/home/domain/entities/home_dashboard.dart';

abstract class HomeRepository {
  Future<HomeDashboard> fetchDashboard();
}
