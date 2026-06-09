import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_track/features/daily_mood/domain/entities/daily_mood.dart';
import 'package:mind_track/features/daily_mood/domain/repositories/daily_mood_repository.dart';

import 'daily_mood_state.dart';

// ViewModel en MVVM: encapsula la lógica de negocio y expone estado al View.
class DailyMoodViewModel extends Cubit<DailyMoodState> {
  DailyMoodViewModel(this._repository) : super(const DailyMoodState()) {
    _subscribeToEntries();
  }

  final DailyMoodRepository _repository;
  StreamSubscription<List<DailyMoodEntry>>? _subscription;

  void _subscribeToEntries() {
    emit(state.copyWith(status: DailyMoodStatus.loading));
    _subscription = _repository.watchAll().listen(
      (List<DailyMoodEntry> entries) {
        emit(state.copyWith(status: DailyMoodStatus.success, entries: entries));
      },
      onError: (Object e) {
        emit(state.copyWith(status: DailyMoodStatus.failure, error: e.toString()));
      },
    );
  }

  Future<void> add(DailyMoodEntry entry) async {
    await _repository.add(entry);
  }

  Future<void> remove(String id) async {
    await _repository.remove(id);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
