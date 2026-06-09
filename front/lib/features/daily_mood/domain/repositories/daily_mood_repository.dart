import '../entities/daily_mood.dart';

abstract class DailyMoodRepository {
  Stream<List<DailyMoodEntry>> watchAll();
  Future<void> add(DailyMoodEntry entry);
  Future<void> remove(String id);
}
