import 'package:mind_track/features/daily_mood/data/datasources/daily_mood_local_datasource.dart';
import 'package:mind_track/features/daily_mood/domain/entities/daily_mood.dart';
import 'package:mind_track/features/daily_mood/domain/repositories/daily_mood_repository.dart';

class DailyMoodRepositoryImpl implements DailyMoodRepository {
  const DailyMoodRepositoryImpl(this._datasource);

  final DailyMoodLocalDatasource _datasource;

  @override
  Stream<List<DailyMoodEntry>> watchAll() => _datasource.watchAll();

  @override
  Future<void> add(DailyMoodEntry entry) => _datasource.add(entry);

  @override
  Future<void> remove(String id) => _datasource.remove(id);
}
