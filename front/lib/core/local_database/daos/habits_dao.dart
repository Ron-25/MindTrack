import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/habits_table.dart';

part 'habits_dao.g.dart';

@DriftAccessor(tables: <Type>[Habits])
class HabitsDao extends DatabaseAccessor<AppDatabase> with _$HabitsDaoMixin {
  HabitsDao(super.db);

  Future<List<Habit>> getAllHabits() => select(habits).get();

  Stream<List<Habit>> watchAllHabits() => select(habits).watch();

  Future<Habit?> getHabitById(String id) {
    return (select(habits)..where(($HabitsTable tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<int> createHabit(HabitsCompanion habit) => into(habits).insert(habit);

  Future<bool> updateHabit(HabitsCompanion habit) => update(habits).replace(habit);

  Future<int> deleteHabit(String id) {
    return (delete(habits)..where(($HabitsTable tbl) => tbl.id.equals(id))).go();
  }
}