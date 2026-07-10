import 'package:equatable/equatable.dart';

class CoachResponse extends Equatable {
  const CoachResponse({
    required this.heroLabel,
    required this.heroDescription,
    required this.insights,
    required this.summary,
  });

  final String heroLabel;
  final String heroDescription;
  final List<CoachInsight> insights;
  final CoachSummary summary;

  @override
  List<Object?> get props => <Object?>[
    heroLabel,
    heroDescription,
    insights,
    summary,
  ];
}

class CoachInsight extends Equatable {
  const CoachInsight({
    required this.code,
    required this.priority,
    required this.message,
  });

  final String code;
  final String priority;
  final String message;

  @override
  List<Object?> get props => <Object?>[code, priority, message];
}

class CoachChatMessage extends Equatable {
  const CoachChatMessage({
    required this.role,
    required this.content,
    required this.sentAt,
  });

  /// 'user' o 'model' (rol que espera la API de Gemini).
  final String role;
  final String content;
  final DateTime sentAt;

  bool get isUser => role == 'user';

  @override
  List<Object?> get props => <Object?>[role, content, sentAt];
}

class CoachSummary extends Equatable {
  const CoachSummary({
    required this.totalLogs,
    this.avgIntensity,
    this.habitsCompletionPct,
    this.dominantEmotionName,
    required this.pendingHabitsCount,
  });

  final int totalLogs;
  final double? avgIntensity;
  final double? habitsCompletionPct;
  final String? dominantEmotionName;
  final int pendingHabitsCount;

  @override
  List<Object?> get props => <Object?>[
    totalLogs,
    avgIntensity,
    habitsCompletionPct,
    dominantEmotionName,
    pendingHabitsCount,
  ];
}
