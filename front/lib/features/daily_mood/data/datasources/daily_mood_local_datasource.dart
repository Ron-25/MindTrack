import 'package:mind_track/core/local_database/app_database.dart';
import 'package:mind_track/core/local_database/daos/daily_moods_dao.dart';
import 'package:mind_track/features/daily_mood/domain/entities/daily_mood.dart';

abstract class DailyMoodLocalDatasource {
  Stream<List<DailyMoodEntry>> watchAll();
  Future<void> add(DailyMoodEntry entry);
  Future<void> remove(String id);
}

class DailyMoodLocalDatasourceImpl implements DailyMoodLocalDatasource {
  const DailyMoodLocalDatasourceImpl(this._dao);

  final DailyMoodsDao _dao;

  @override
  Stream<List<DailyMoodEntry>> watchAll() {
    return _dao.watchAll().map(
      (List<DailyMood> rows) => rows
          .map(
            (DailyMood r) => DailyMoodEntry(
              id: r.id,
              mood: r.mood,
              note: r.note,
              createdAt: r.createdAt,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<void> add(DailyMoodEntry entry) {
    return _dao.insertEntry(
      DailyMoodsCompanion.insert(
        id: entry.id,
        mood: entry.mood,
        note: entry.note,
        createdAt: entry.createdAt,
      ),
    );
  }

  @override
  Future<void> remove(String id) => _dao.deleteEntry(id);
}
