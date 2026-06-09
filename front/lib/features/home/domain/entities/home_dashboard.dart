import 'package:equatable/equatable.dart';

class HomeDashboard extends Equatable {
  const HomeDashboard({
    required this.userName,
    required this.todayMood,
    required this.weeklyOverview,
    required this.habits,
    required this.recentEntries,
  });

  final String userName;
  final TodayMoodSummary todayMood;
  final WeeklyOverview weeklyOverview;
  final List<HabitOverview> habits;
  final List<RecentEmotionEntry> recentEntries;

  @override
  List<Object?> get props => <Object?>[
    userName,
    todayMood,
    weeklyOverview,
    habits,
    recentEntries,
  ];
}

class TodayMoodSummary extends Equatable {
  const TodayMoodSummary({
    required this.statusLabel,
    required this.primaryEmotionName,
    required this.insightText,
    required this.totalEntries,
    this.energyLevelKey,
    this.colorHex,
    this.iconKey,
  });

  final String statusLabel;
  final String primaryEmotionName;
  final String insightText;
  final int totalEntries;
  final String? energyLevelKey;
  final String? colorHex;
  final String? iconKey;

  @override
  List<Object?> get props => <Object?>[
    statusLabel,
    primaryEmotionName,
    insightText,
    totalEntries,
    energyLevelKey,
    colorHex,
    iconKey,
  ];
}

class WeeklyOverview extends Equatable {
  const WeeklyOverview({required this.bars, required this.insightText});

  final List<WeeklyOverviewBar> bars;
  final String insightText;

  @override
  List<Object?> get props => <Object?>[bars, insightText];
}

class WeeklyOverviewBar extends Equatable {
  const WeeklyOverviewBar({
    required this.label,
    required this.value,
    required this.isHighlighted,
  });

  final String label;
  final double value;
  final bool isHighlighted;

  @override
  List<Object?> get props => <Object?>[label, value, isHighlighted];
}

class HabitOverview extends Equatable {
  const HabitOverview({
    required this.id,
    required this.name,
    required this.isCompletedToday,
    this.iconKey,
    this.colorHex,
  });

  final String id;
  final String name;
  final bool isCompletedToday;
  final String? iconKey;
  final String? colorHex;

  @override
  List<Object?> get props => <Object?>[
    id,
    name,
    isCompletedToday,
    iconKey,
    colorHex,
  ];
}

class RecentEmotionEntry extends Equatable {
  const RecentEmotionEntry({
    required this.id,
    required this.emotionName,
    required this.loggedAt,
    this.note,
    this.colorHex,
    this.iconKey,
  });

  final String id;
  final String emotionName;
  final DateTime loggedAt;
  final String? note;
  final String? colorHex;
  final String? iconKey;

  @override
  List<Object?> get props => <Object?>[
    id,
    emotionName,
    loggedAt,
    note,
    colorHex,
    iconKey,
  ];
}
