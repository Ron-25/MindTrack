import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/emotion_entries_table.dart';

part 'emotion_entries_dao.g.dart';

@DriftAccessor(tables: <Type>[EmotionEntries])
class EmotionEntriesDao extends DatabaseAccessor<AppDatabase>
    with _$EmotionEntriesDaoMixin {
  EmotionEntriesDao(super.db);

  Future<List<EmotionEntry>> getAllEmotionEntries() =>
      select(emotionEntries).get();

  Stream<List<EmotionEntry>> watchAllEmotionEntries() =>
      select(emotionEntries).watch();

  Future<EmotionEntry?> getEmotionEntryById(String id) {
    return (select(emotionEntries)
          ..where(($EmotionEntriesTable tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> createEmotionEntry(EmotionEntriesCompanion entry) =>
      into(emotionEntries).insert(entry);

  Future<bool> updateEmotionEntry(EmotionEntriesCompanion entry) =>
      update(emotionEntries).replace(entry);

  Future<int> deleteEmotionEntry(String id) {
    return (delete(
      emotionEntries,
    )..where(($EmotionEntriesTable tbl) => tbl.id.equals(id))).go();
  }
}
