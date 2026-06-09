import 'package:dio/dio.dart';
import 'package:mind_track/core/network/api_client.dart';
import 'package:mind_track/features/home/domain/entities/home_dashboard.dart';

abstract class HomeRemoteDataSource {
  Future<HomeDashboard> fetchDashboard();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl(this._client);

  final ApiClient _client;

  @override
  Future<HomeDashboard> fetchDashboard() async {
    try {
      final DateTime now = DateTime.now();
      final DateTime weekStart = _startOfWeek(now);
      final DateTime startOfToday = DateTime(now.year, now.month, now.day);

      final List<Response<dynamic>> responses = await Future.wait(
        <Future<Response<dynamic>>>[
          _client.dio.get<dynamic>('/api/v1/auth/me'),
          _client.dio.get<dynamic>(
            '/api/v1/emotions',
            queryParameters: <String, dynamic>{
              'start_date': startOfToday.toIso8601String(),
              'end_date': now.toIso8601String(),
              'limit': 20,
            },
          ),
          _client.dio.get<dynamic>(
            '/api/v1/emotions',
            queryParameters: <String, dynamic>{'limit': 5},
          ),
          _client.dio.get<dynamic>(
            '/api/v1/analytics/weekly-summary',
            queryParameters: <String, dynamic>{
              'week_start': _formatDateOnly(weekStart),
            },
          ),
          _client.dio.get<dynamic>(
            '/api/v1/analytics/habits-mood',
            queryParameters: <String, dynamic>{'days': 7},
          ),
          _client.dio.get<dynamic>('/api/v1/habits'),
        ],
      );

      final Map<String, dynamic> userJson =
          responses[0].data as Map<String, dynamic>;
      final List<dynamic> todayEntriesJson = responses[1].data as List<dynamic>;
      final List<dynamic> recentEntriesJson =
          responses[2].data as List<dynamic>;
      final Map<String, dynamic> weeklySummaryJson =
          responses[3].data as Map<String, dynamic>;
      final List<dynamic> habitsMoodJson = responses[4].data as List<dynamic>;
      final List<dynamic> habitsJson = responses[5].data as List<dynamic>;

      final List<Map<String, dynamic>> habitProgressJson =
          await _loadHabitProgress(habitsJson, weekStart);

      return HomeDashboard(
        userName: (userJson['name'] as String?)?.trim().isNotEmpty == true
            ? userJson['name'] as String
            : 'Alex',
        todayMood: _buildTodayMood(
          todayEntriesJson.cast<Map<String, dynamic>>(),
          weeklySummaryJson,
        ),
        weeklyOverview: _buildWeeklyOverview(
          habitsMoodJson.cast<Map<String, dynamic>>(),
          weeklySummaryJson,
        ),
        habits: _buildHabits(
          habitsJson.cast<Map<String, dynamic>>(),
          habitProgressJson,
          now,
        ),
        recentEntries: _buildRecentEntries(
          recentEntriesJson.cast<Map<String, dynamic>>(),
        ),
      );
    } on DioException catch (error) {
      throw Exception(_extractMessage(error));
    }
  }

  Future<List<Map<String, dynamic>>> _loadHabitProgress(
    List<dynamic> habitsJson,
    DateTime weekStart,
  ) async {
    final List<Map<String, dynamic>> firstHabits = habitsJson
        .cast<Map<String, dynamic>>()
        .take(3)
        .toList();
    if (firstHabits.isEmpty) {
      return <Map<String, dynamic>>[];
    }

    final List<Response<dynamic>> progressResponses = await Future.wait(
      <Future<Response<dynamic>>>[
        for (final Map<String, dynamic> habit in firstHabits)
          _client.dio.get<dynamic>(
            '/api/v1/habits/${habit['id']}/progress',
            queryParameters: <String, dynamic>{
              'week_start': _formatDateOnly(weekStart),
            },
          ),
      ],
    );

    return progressResponses
        .map(
          (Response<dynamic> response) => response.data as Map<String, dynamic>,
        )
        .toList();
  }

  TodayMoodSummary _buildTodayMood(
    List<Map<String, dynamic>> todayEntries,
    Map<String, dynamic> weeklySummaryJson,
  ) {
    if (todayEntries.isEmpty) {
      return const TodayMoodSummary(
        statusLabel: 'new_day',
        primaryEmotionName: '',
        insightText: '',
        totalEntries: 0,
      );
    }

    final Map<String, int> counts = <String, int>{};
    double totalIntensity = 0;
    Map<String, dynamic>? dominantEntry;

    for (final Map<String, dynamic> entry in todayEntries) {
      final Map<String, dynamic> emotionType =
          entry['emotion_type'] as Map<String, dynamic>;
      final String emotionName = (emotionType['name'] as String?) ?? 'Emotion';
      counts[emotionName] = (counts[emotionName] ?? 0) + 1;
      totalIntensity += (entry['intensity'] as num?)?.toDouble() ?? 0;
      dominantEntry ??= entry;
      if ((counts[emotionName] ?? 0) >
          (counts[(dominantEntry['emotion_type']
                      as Map<String, dynamic>)['name']
                  as String] ??
              0)) {
        dominantEntry = entry;
      }
    }

    dominantEntry ??= todayEntries.first;
    final Map<String, dynamic> dominantEmotion =
        dominantEntry['emotion_type'] as Map<String, dynamic>;
    final double averageIntensity = totalIntensity / todayEntries.length;
    final String primaryEmotionName =
        (dominantEmotion['name'] as String?) ?? 'Balanced';

    return TodayMoodSummary(
      statusLabel: _statusLabelForIntensity(averageIntensity),
      primaryEmotionName: primaryEmotionName,
      insightText:
          (weeklySummaryJson['insight_text'] as String?)?.trim().isNotEmpty ==
              true
          ? weeklySummaryJson['insight_text'] as String
          : 'Keep noticing what influences your mood during the day.',
      totalEntries: todayEntries.length,
      energyLevelKey: _energyLevelText(averageIntensity),
      colorHex: dominantEmotion['color_hex'] as String?,
      iconKey: dominantEmotion['icon'] as String?,
    );
  }

  WeeklyOverview _buildWeeklyOverview(
    List<Map<String, dynamic>> habitsMoodJson,
    Map<String, dynamic> weeklySummaryJson,
  ) {
    final List<String> labels = <String>[
      'MON',
      'TUE',
      'WED',
      'THU',
      'FRI',
      'SAT',
      'SUN',
    ];
    final Map<String, double> valuesByDay = <String, double>{};

    for (final Map<String, dynamic> item in habitsMoodJson) {
      final String? rawDate = item['date'] as String?;
      if (rawDate == null) {
        continue;
      }
      final DateTime parsedDate = DateTime.parse(rawDate);
      final String label = labels[parsedDate.weekday - 1];
      final double intensity = (item['avg_intensity'] as num?)?.toDouble() ?? 0;
      valuesByDay[label] = intensity;
    }

    final List<double> rawValues = labels
        .map((String label) => valuesByDay[label] ?? 0)
        .toList();
    final double maxValue = rawValues.fold<double>(
      1,
      (double current, double value) => value > current ? value : current,
    );

    final List<WeeklyOverviewBar> bars = List<WeeklyOverviewBar>.generate(
      labels.length,
      (int index) {
        final double normalized = ((rawValues[index] / maxValue) * 100).clamp(
          28,
          100,
        );
        return WeeklyOverviewBar(
          label: labels[index],
          value: rawValues[index] == 0 ? 28 : normalized,
          isHighlighted: index >= 5,
        );
      },
    );

    return WeeklyOverview(
      bars: bars,
      insightText:
          (weeklySummaryJson['insight_text'] as String?)?.trim().isNotEmpty ==
              true
          ? weeklySummaryJson['insight_text'] as String
          : 'Your week is still taking shape. Keep logging to see patterns.',
    );
  }

  List<HabitOverview> _buildHabits(
    List<Map<String, dynamic>> habitsJson,
    List<Map<String, dynamic>> habitProgressJson,
    DateTime now,
  ) {
    final DateTime today = DateTime(now.year, now.month, now.day);
    final Map<String, Map<String, dynamic>> progressByHabitId =
        <String, Map<String, dynamic>>{
          for (final Map<String, dynamic> progress in habitProgressJson)
            ((progress['habit'] as Map<String, dynamic>)['id'] as String):
                progress,
        };

    return habitsJson.cast<Map<String, dynamic>>().take(3).map((
      Map<String, dynamic> habit,
    ) {
      final String habitId = habit['id'] as String;
      final Map<String, dynamic>? progress = progressByHabitId[habitId];
      final List<dynamic> logs =
          progress?['logs'] as List<dynamic>? ?? <dynamic>[];
      final bool completedToday = logs.any((dynamic log) {
        final Map<String, dynamic> item = log as Map<String, dynamic>;
        final DateTime completedDate = DateTime.parse(
          item['completed_date'] as String,
        );
        final DateTime normalizedDate = DateTime(
          completedDate.year,
          completedDate.month,
          completedDate.day,
        );
        return normalizedDate == today && item['status'] == 'done';
      });

      return HabitOverview(
        id: habitId,
        name: (habit['name'] as String?) ?? 'Habit',
        isCompletedToday: completedToday,
        iconKey: habit['icon'] as String?,
        colorHex: habit['color_hex'] as String?,
      );
    }).toList();
  }

  List<RecentEmotionEntry> _buildRecentEntries(
    List<Map<String, dynamic>> recentEntriesJson,
  ) {
    return recentEntriesJson.take(2).map((Map<String, dynamic> entry) {
      final Map<String, dynamic> emotionType =
          entry['emotion_type'] as Map<String, dynamic>;
      return RecentEmotionEntry(
        id: entry['id'] as String,
        emotionName: (emotionType['name'] as String?) ?? 'Emotion',
        loggedAt: DateTime.parse(entry['logged_at'] as String),
        note: entry['note'] as String?,
        colorHex: emotionType['color_hex'] as String?,
        iconKey: emotionType['icon'] as String?,
      );
    }).toList();
  }

  String _statusLabelForIntensity(double averageIntensity) {
    if (averageIntensity >= 7.5) {
      return 'elevated';
    }
    if (averageIntensity >= 4.5) {
      return 'stable';
    }
    return 'gentle';
  }

  String _energyLevelText(double averageIntensity) {
    if (averageIntensity >= 7.5) {
      return 'high';
    }
    if (averageIntensity >= 4.5) {
      return 'balanced';
    }
    return 'low';
  }

  DateTime _startOfWeek(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
    ).subtract(Duration(days: date.weekday - 1));
  }

  String _formatDateOnly(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  String _extractMessage(DioException error) {
    final dynamic data = error.response?.data;
    if (data is Map<String, dynamic>) {
      return (data['detail'] as String?) ?? 'Could not load your dashboard.';
    }
    if (error.type == DioExceptionType.connectionError) {
      return 'Could not connect to the server.';
    }
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return 'The request timed out.';
    }
    if (error.response?.statusCode == 401) {
      return 'Your session expired. Please sign in again.';
    }
    return 'Could not load your dashboard.';
  }
}
