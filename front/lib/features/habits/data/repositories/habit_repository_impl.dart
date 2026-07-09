import 'package:mind_track/features/habits/data/datasources/habit_remote_datasource.dart';
import 'package:mind_track/features/habits/domain/entities/habit_tracker.dart';
import 'package:mind_track/features/habits/domain/repositories/habit_repository.dart';

class HabitRepositoryImpl implements HabitRepository {
  const HabitRepositoryImpl(this._remoteDataSource);

  final HabitRemoteDataSource _remoteDataSource;

  @override
  Future<List<HabitTracker>> fetchHabits() {
    return _remoteDataSource.fetchHabits();
  }

  @override
  Future<void> toggleHabit(String id, {required bool completed}) {
    return _remoteDataSource.toggleHabit(id, completed: completed);
  }

  @override
  Future<void> createHabit(CreateHabitInput input) {
    return _remoteDataSource.createHabit(input);
  }
}
