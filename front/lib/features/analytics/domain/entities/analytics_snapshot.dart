import 'package:equatable/equatable.dart';

class AnalyticsSnapshot extends Equatable {
  const AnalyticsSnapshot({
    required this.weeklySummary,
    required this.frequency,
    required this.correlation,
  });

  final WeeklySummaryData weeklySummary;
  final List<EmotionFrequencyItem> frequency;
  final List<HabitMoodPoint> correlation;

  @override
  List<Object?> get props => <Object?>[weeklySummary, frequency, correlation];
}

class WeeklySummaryData extends Equatable {
  const WeeklySummaryData({
    required this.totalLogs,
    this.avgIntensity,
    this.habitsCompletionPct,
    this.dominantEmotionName,
    this.dominantEmotionColorHex,
    this.insightText,
  });

  final int totalLogs;
  final double? avgIntensity;
  final double? habitsCompletionPct;
  final String? dominantEmotionName;
  final String? dominantEmotionColorHex;
  final String? insightText;

  @override
  List<Object?> get props => <Object?>[
    totalLogs,
    avgIntensity,
    habitsCompletionPct,
    dominantEmotionName,
    dominantEmotionColorHex,
    insightText,
  ];
}

class EmotionFrequencyItem extends Equatable {
  const EmotionFrequencyItem({
    required this.name,
    required this.count,
    required this.percentage,
    this.colorHex,
  });

  final String name;
  final int count;
  final double percentage;
  final String? colorHex;

  @override
  List<Object?> get props => <Object?>[name, count, percentage, colorHex];
}

class HabitMoodPoint extends Equatable {
  const HabitMoodPoint({
    required this.date,
    required this.habitsCompleted,
    this.avgIntensity,
  });

  final DateTime date;
  final int habitsCompleted;
  final double? avgIntensity;

  @override
  List<Object?> get props => <Object?>[date, habitsCompleted, avgIntensity];
}
