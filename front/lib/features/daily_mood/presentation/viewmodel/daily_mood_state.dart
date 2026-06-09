import 'package:equatable/equatable.dart';
import 'package:mind_track/features/daily_mood/domain/entities/daily_mood.dart';

enum DailyMoodStatus { initial, loading, success, failure }

class DailyMoodState extends Equatable {
  const DailyMoodState({
    this.status = DailyMoodStatus.initial,
    this.entries = const <DailyMoodEntry>[],
    this.error,
  });

  final DailyMoodStatus status;
  final List<DailyMoodEntry> entries;
  final String? error;

  DailyMoodState copyWith({
    DailyMoodStatus? status,
    List<DailyMoodEntry>? entries,
    String? error,
  }) {
    return DailyMoodState(
      status: status ?? this.status,
      entries: entries ?? this.entries,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, entries, error];
}
