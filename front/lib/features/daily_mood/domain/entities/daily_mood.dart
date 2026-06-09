class DailyMoodEntry {
  const DailyMoodEntry({
    required this.id,
    required this.mood,
    required this.note,
    required this.createdAt,
  });

  final String id;
  final String mood;
  final String note;
  final DateTime createdAt;
}
