import 'package:mind_track/features/habits/domain/entities/habit_tracker.dart';

abstract class HabitRepository {
  Future<List<HabitTracker>> fetchHabits();

  Future<void> toggleHabit(String id, {required bool completed});

  Future<void> createHabit(CreateHabitInput input);

  Future<void> updateHabit(String id, UpdateHabitInput input);
}
