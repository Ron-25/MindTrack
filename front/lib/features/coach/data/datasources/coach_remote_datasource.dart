import 'package:dio/dio.dart';
import 'package:mind_track/core/network/api_client.dart';
import 'package:mind_track/features/coach/domain/entities/coach_response.dart';

abstract class CoachRemoteDataSource {
  Future<CoachResponse> fetchCoachResponse();

  Future<String> sendChatMessage({
    required String message,
    required List<CoachChatMessage> history,
  });
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

  @override
  Future<String> sendChatMessage({
    required String message,
    required List<CoachChatMessage> history,
  }) async {
    try {
      final Response<dynamic> response = await _client.dio.post<dynamic>(
        '/api/v1/coach/chat',
        data: <String, dynamic>{
          'message': message,
          'history': history
              .map(
                (CoachChatMessage item) => <String, String>{
                  'role': item.role,
                  'content': item.content,
                },
              )
              .toList(growable: false),
        },
      );
      final Map<String, dynamic> json = response.data as Map<String, dynamic>;
      final String reply = json['reply'] as String? ?? '';
      if (reply.trim().isEmpty) {
        throw Exception('El asistente devolvió una respuesta vacía.');
      }
      return reply;
    } on DioException catch (error) {
      throw Exception(
        _extractMessage(error, fallback: 'No se pudo enviar el mensaje.'),
      );
    }
  }

  String _extractMessage(
    DioException error, {
    String fallback = 'No se pudo cargar el coach.',
  }) {
    final dynamic data = error.response?.data;
    if (data is Map) {
      final dynamic detail = data['detail'];
      if (detail is String && detail.trim().isNotEmpty) {
        return detail;
      }
    }
    final int? statusCode = error.response?.statusCode;
    if (statusCode != null) {
      return '$fallback (error $statusCode).';
    }
    if (error.type == DioExceptionType.connectionError) {
      return 'No se pudo conectar con el servidor.';
    }
    return fallback;
  }
}
