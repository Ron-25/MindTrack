import 'package:dio/dio.dart';
import 'package:mind_track/core/network/api_client.dart';
import 'package:mind_track/features/coach/domain/entities/coach_response.dart';

abstract class CoachRemoteDataSource {
  Future<CoachResponse> fetchCoachResponse();
}

class CoachRemoteDataSourceImpl implements CoachRemoteDataSource {
  const CoachRemoteDataSourceImpl(this._client);

  final ApiClient _client;

  @override
  Future<CoachResponse> fetchCoachResponse() async {
    try {
      final Response<dynamic> response = await _client.dio.get<dynamic>(
        '/api/v1/coach/insights',
      );
      final Map<String, dynamic> json = response.data as Map<String, dynamic>;
      final Map<String, dynamic> summary =
          json['summary'] as Map<String, dynamic>? ?? <String, dynamic>{};
      final List<dynamic> insightsJson =
          json['insights'] as List<dynamic>? ?? <dynamic>[];

      return CoachResponse(
        heroLabel: json['hero_label'] as String? ?? 'AI Coach',
        heroDescription:
            json['hero_description'] as String? ?? 'Actionable suggestions.',
        insights: insightsJson
            .cast<Map<String, dynamic>>()
            .map(
              (Map<String, dynamic> item) => CoachInsight(
                code: item['code'] as String? ?? 'unknown',
                priority: item['priority'] as String? ?? 'low',
                message: item['message'] as String? ?? '',
              ),
            )
            .toList(growable: false),
        summary: CoachSummary(
          totalLogs: (summary['total_logs'] as num?)?.toInt() ?? 0,
          avgIntensity: (summary['avg_intensity'] as num?)?.toDouble(),
          habitsCompletionPct: (summary['habits_completion_pct'] as num?)
              ?.toDouble(),
          dominantEmotionName: summary['dominant_emotion_name'] as String?,
          pendingHabitsCount:
              (summary['pending_habits_count'] as num?)?.toInt() ?? 0,
        ),
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
    return 'No se pudo cargar el coach.';
  }
}
