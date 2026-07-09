import 'package:dio/dio.dart';
import 'package:mind_track/core/network/api_client.dart';
import 'package:mind_track/features/analytics/domain/entities/analytics_snapshot.dart';

abstract class AnalyticsRemoteDataSource {
  Future<AnalyticsSnapshot> fetchSnapshot({int days = 30});
}

class AnalyticsRemoteDataSourceImpl implements AnalyticsRemoteDataSource {
  const AnalyticsRemoteDataSourceImpl(this._client);

  final ApiClient _client;

  @override
  Future<AnalyticsSnapshot> fetchSnapshot({int days = 30}) async {
    try {
      final DateTime now = DateTime.now();
      final DateTime weekStart = now.subtract(Duration(days: now.weekday - 1));
      final List<Response<dynamic>>
      responses = await Future.wait(<Future<Response<dynamic>>>[
        _client.dio.get<dynamic>(
          '/api/v1/analytics/weekly-summary',
          queryParameters: <String, dynamic>{
            'week_start':
                '${weekStart.year.toString().padLeft(4, '0')}-${weekStart.month.toString().padLeft(2, '0')}-${weekStart.day.toString().padLeft(2, '0')}',
          },
        ),
        _client.dio.get<dynamic>(
          '/api/v1/analytics/emotion-frequency',
          queryParameters: <String, dynamic>{'days': days},
        ),
        _client.dio.get<dynamic>(
          '/api/v1/analytics/habits-mood',
          queryParameters: <String, dynamic>{'days': days},
        ),
      ]);

      final Map<String, dynamic> weekly =
          responses[0].data as Map<String, dynamic>;
      final List<dynamic> frequency = responses[1].data as List<dynamic>;
      final List<dynamic> correlation = responses[2].data as List<dynamic>;

      final Map<String, dynamic>? dominantEmotion =
          weekly['dominant_emotion'] as Map<String, dynamic>?;

      return AnalyticsSnapshot(
        weeklySummary: WeeklySummaryData(
          totalLogs: (weekly['total_logs'] as num?)?.toInt() ?? 0,
          avgIntensity: (weekly['avg_intensity'] as num?)?.toDouble(),
          habitsCompletionPct: (weekly['habits_completion_pct'] as num?)
              ?.toDouble(),
          dominantEmotionName:
              dominantEmotion?['name_es'] as String? ??
              dominantEmotion?['name'] as String?,
          dominantEmotionColorHex: dominantEmotion?['color_hex'] as String?,
          insightText: weekly['insight_text'] as String?,
        ),
        frequency: frequency
            .cast<Map<String, dynamic>>()
            .map((Map<String, dynamic> item) {
              final Map<String, dynamic> emotionType =
                  item['emotion_type'] as Map<String, dynamic>;
              return EmotionFrequencyItem(
                name:
                    emotionType['name_es'] as String? ??
                    emotionType['name'] as String? ??
                    'Emotion',
                count: (item['count'] as num?)?.toInt() ?? 0,
                percentage: (item['percentage'] as num?)?.toDouble() ?? 0,
                colorHex: emotionType['color_hex'] as String?,
              );
            })
            .toList(growable: false),
        correlation: correlation
            .cast<Map<String, dynamic>>()
            .map(
              (Map<String, dynamic> item) => HabitMoodPoint(
                date: DateTime.parse(item['date'] as String),
                habitsCompleted:
                    (item['habits_completed'] as num?)?.toInt() ?? 0,
                avgIntensity: (item['avg_intensity'] as num?)?.toDouble(),
              ),
            )
            .toList(growable: false),
      );
    } on DioException catch (error) {
      throw Exception(_extractMessage(error));
    }
  }

  String _extractMessage(DioException error) {
    final dynamic data = error.response?.data;
    if (data is Map<String, dynamic>) {
      final dynamic detail = data['detail'];
      if (detail is String && detail.trim().isNotEmpty) {
        return detail;
      }
    }
    if (error.type == DioExceptionType.connectionError) {
      return 'No se pudo conectar con el servidor.';
    }
    return 'No se pudieron cargar las analíticas.';
  }
}
