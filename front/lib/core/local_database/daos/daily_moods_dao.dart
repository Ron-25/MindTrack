import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/daily_moods_table.dart';

part 'daily_moods_dao.g.dart';

@DriftAccessor(tables: <Type>[DailyMoods])
class DailyMoodsDao extends DatabaseAccessor<AppDatabase>
    with _$DailyMoodsDaoMixin {
  DailyMoodsDao(super.db);

  Stream<List<DailyMood>> watchAll() =>
      (select(dailyMoods)
            ..orderBy(
              <OrderingTerm Function($DailyMoodsTable)>[
                ($DailyMoodsTable t) => OrderingTerm.desc(t.createdAt),
              ],
            ))
          .watch();

  Future<int> insertEntry(DailyMoodsCompanion entry) =>
      into(dailyMoods).insert(entry);

  Future<int> deleteEntry(String id) =>
      (delete(dailyMoods)..where(($DailyMoodsTable t) => t.id.equals(id)))
          .go();
}
