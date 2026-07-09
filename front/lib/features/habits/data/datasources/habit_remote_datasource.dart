import 'package:dio/dio.dart';
import 'package:mind_track/core/network/api_client.dart';
import 'package:mind_track/features/habits/domain/entities/habit_tracker.dart';

abstract class HabitRemoteDataSource {
  Future<List<HabitTracker>> fetchHabits();

  Future<void> toggleHabit(String id, {required bool completed});

  Future<void> createHabit(CreateHabitInput input);
}

class HabitRemoteDataSourceImpl implements HabitRemoteDataSource {
  const HabitRemoteDataSourceImpl(this._client);

  final ApiClient _client;

  @override
  Future<List<HabitTracker>> fetchHabits() async {
    try {
      final DateTime now = DateTime.now();
      final DateTime weekStart = now.subtract(Duration(days: now.weekday - 1));
      final Response<dynamic> listResponse = await _client.dio.get<dynamic>(
        '/api/v1/habits',
      );
      final List<Map<String, dynamic>> habits =
          (listResponse.data as List<dynamic>).cast<Map<String, dynamic>>();
      if (habits.isEmpty) {
        return <HabitTracker>[];
      }
      final List<Response<dynamic>>
      progressResponses = await Future.wait(<Future<Response<dynamic>>>[
        for (final Map<String, dynamic> habit in habits)
          _client.dio.get<dynamic>(
            '/api/v1/habits/${habit['id']}/progress',
            queryParameters: <String, dynamic>{
              'week_start':
                  '${weekStart.year.toString().padLeft(4, '0')}-${weekStart.month.toString().padLeft(2, '0')}-${weekStart.day.toString().padLeft(2, '0')}',
            },
          ),
      ]);

      return progressResponses
          .map((Response<dynamic> response) {
            final Map<String, dynamic> progress =
                response.data as Map<String, dynamic>;
            final Map<String, dynamic> habit =
                progress['habit'] as Map<String, dynamic>;
            final List<dynamic> logs =
                progress['logs'] as List<dynamic>? ?? <dynamic>[];
            final bool completedToday = logs.any((dynamic log) {
              final DateTime date = DateTime.parse(
                (log as Map<String, dynamic>)['completed_date'] as String,
              );
              return date.year == now.year &&
                  date.month == now.month &&
                  date.day == now.day &&
                  log['status'] == 'done';
            });
            return HabitTracker(
              id: habit['id'] as String,
              name: habit['name'] as String? ?? 'Habit',
              description: habit['description'] as String?,
              iconKey: habit['icon'] as String?,
              colorHex: habit['color_hex'] as String?,
              category: habit['category'] as String?,
              targetDaysWeek: (habit['target_days_week'] as num?)?.toInt() ?? 1,
              completedDays: (progress['completed_days'] as num?)?.toInt() ?? 0,
              completionPct:
                  (progress['completion_pct'] as num?)?.toDouble() ?? 0,
              completedToday: completedToday,
            );
          })
          .toList(growable: false);
    } on DioException catch (error) {
      throw Exception(_extractMessage(error));
    }
  }

  @override
  Future<void> toggleHabit(String id, {required bool completed}) async {
    try {
      final DateTime now = DateTime.now();
      await _client.dio.post<dynamic>(
        '/api/v1/habits/$id/logs',
        data: <String, dynamic>{
          'completed_date':
              '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
          'status': completed ? 'done' : 'skipped',
        },
      );
    } on DioException catch (error) {
      throw Exception(_extractMessage(error));
    }
  }

  @override
  Future<void> createHabit(CreateHabitInput input) async {
    try {
      await _client.dio.post<dynamic>(
        '/api/v1/habits',
        data: <String, dynamic>{
          'name': input.name,
          'description': input.description?.trim().isEmpty == true
              ? null
              : input.description,
          'category': input.category?.trim().isEmpty == true
              ? null
              : input.category,
          'target_days_week': input.targetDaysWeek,
        },
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
    return 'No se pudieron cargar los hábitos.';
  }
}
