import 'package:dio/dio.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/core/network/api_client.dart';
import 'package:mind_track/features/emotion_tracker/domain/entities/emotion_entry.dart';

abstract class EmotionRemoteDataSource {
  Future<List<EmotionEntry>> fetchEntries({int limit = 50});

  Future<EmotionEntry> fetchEntry(String id);

  Future<List<EmotionTypeOption>> fetchEmotionTypes();

  Future<List<EmotionTag>> fetchTags();

  Future<EmotionEntry> createEntry(CreateEmotionEntryInput input);

  Future<EmotionEntry> updateEntry(String id, UpdateEmotionEntryInput input);

  Future<void> deleteEntry(String id);
}

class EmotionRemoteDataSourceImpl implements EmotionRemoteDataSource {
  const EmotionRemoteDataSourceImpl(this._client);

  final ApiClient _client;

  @override
  Future<List<EmotionEntry>> fetchEntries({int limit = 50}) async {
    try {
      final Response<dynamic> response = await _client.dio.get<dynamic>(
        '/api/v1/emotions/',
        queryParameters: <String, dynamic>{'limit': limit},
      );
      final List<dynamic> json = response.data as List<dynamic>;
      return json
          .cast<Map<String, dynamic>>()
          .map(_mapEmotionEntry)
          .toList(growable: false);
    } on DioException catch (error) {
      throw Exception(_extractMessage(error, S.current.err_load_history));
    }
  }

  @override
  Future<EmotionEntry> fetchEntry(String id) async {
    try {
      final Response<dynamic> response = await _client.dio.get<dynamic>(
        '/api/v1/emotions/$id',
      );
      return _mapEmotionEntry(response.data as Map<String, dynamic>);
    } on DioException catch (error) {
      throw Exception(
        _extractMessage(error, S.current.err_load_emotion_detail),
      );
    }
  }

  @override
  Future<List<EmotionTypeOption>> fetchEmotionTypes() async {
    try {
      final Response<dynamic> response = await _client.dio.get<dynamic>(
        '/api/v1/emotion-types/',
      );
      final List<dynamic> json = response.data as List<dynamic>;
      return json
          .cast<Map<String, dynamic>>()
          .map(_mapEmotionType)
          .toList(growable: false);
    } on DioException catch (error) {
      throw Exception(_extractMessage(error, S.current.err_load_emotion_types));
    }
  }

  @override
  Future<List<EmotionTag>> fetchTags() async {
    try {
      final Response<dynamic> response = await _client.dio.get<dynamic>(
        '/api/v1/tags/',
      );
      final List<dynamic> json = response.data as List<dynamic>;
      return json
          .cast<Map<String, dynamic>>()
          .map(_mapEmotionTag)
          .toList(growable: false);
    } on DioException catch (error) {
      throw Exception(_extractMessage(error, S.current.err_load_tags));
    }
  }

  @override
  Future<EmotionEntry> createEntry(CreateEmotionEntryInput input) async {
    try {
      final Response<dynamic> response = await _client.dio.post<dynamic>(
        '/api/v1/emotions/',
        data: <String, dynamic>{
          'emotion_type_id': input.emotionTypeId,
          'intensity': input.intensity,
          'note': _normalizeNullable(input.note),
          'context_place': _normalizeNullable(input.contextPlace),
          'context_activity': _normalizeNullable(input.contextActivity),
          'context_people': _normalizeNullable(input.contextPeople),
          'tag_ids': input.tagIds,
          'logged_at': input.loggedAt.toIso8601String(),
        },
      );
      return _mapEmotionEntry(response.data as Map<String, dynamic>);
    } on DioException catch (error) {
      throw Exception(_extractMessage(error, S.current.err_save_emotion));
    }
  }

  @override
  Future<EmotionEntry> updateEntry(
    String id,
    UpdateEmotionEntryInput input,
  ) async {
    try {
      final Response<dynamic> response = await _client.dio.patch<dynamic>(
        '/api/v1/emotions/$id',
        data: <String, dynamic>{
          if (input.intensity != null) 'intensity': input.intensity,
          if (input.note != null) 'note': _normalizeNullable(input.note),
          if (input.tagIds != null) 'tag_ids': input.tagIds,
        },
      );
      return _mapEmotionEntry(response.data as Map<String, dynamic>);
    } on DioException catch (error) {
      throw Exception(_extractMessage(error, S.current.err_update_emotion));
    }
  }

  @override
  Future<void> deleteEntry(String id) async {
    try {
      await _client.dio.delete<void>('/api/v1/emotions/$id');
    } on DioException catch (error) {
      throw Exception(_extractMessage(error, S.current.err_delete_emotion));
    }
  }

  EmotionEntry _mapEmotionEntry(Map<String, dynamic> json) {
    final Map<String, dynamic> emotionType =
        json['emotion_type'] as Map<String, dynamic>? ?? <String, dynamic>{};
    final List<dynamic> rawTags = json['tags'] as List<dynamic>? ?? <dynamic>[];
    return EmotionEntry(
      id: json['id'] as String,
      emotionTypeId: emotionType['id'] as String? ?? '',
      emotionName: emotionType['name'] as String? ?? 'Emotion',
      emotionNameEs: emotionType['name_es'] as String?,
      intensity: (json['intensity'] as num?)?.toInt() ?? 5,
      note: json['note'] as String?,
      contextPlace: json['context_place'] as String?,
      contextActivity: json['context_activity'] as String?,
      contextPeople: json['context_people'] as String?,
      tags: rawTags
          .cast<Map<String, dynamic>>()
          .map(_mapEmotionTag)
          .toList(growable: false),
      loggedAt: DateTime.parse(json['logged_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      colorHex: emotionType['color_hex'] as String?,
      iconKey: emotionType['icon'] as String?,
    );
  }

  EmotionTypeOption _mapEmotionType(Map<String, dynamic> json) {
    return EmotionTypeOption(
      id: json['id'] as String,
      name: json['name'] as String? ?? 'Emotion',
      nameEs: json['name_es'] as String?,
      colorHex: json['color_hex'] as String? ?? '#5FA9D3',
      iconKey: json['icon'] as String?,
    );
  }

  EmotionTag _mapEmotionTag(Map<String, dynamic> json) {
    return EmotionTag(
      id: json['id'] as String,
      name: json['name'] as String? ?? 'Tag',
      colorHex: json['color_hex'] as String?,
    );
  }

  String? _normalizeNullable(String? value) {
    final String trimmed = value?.trim() ?? '';
    return trimmed.isEmpty ? null : trimmed;
  }

  String _extractMessage(DioException error, String fallback) {
    final dynamic data = error.response?.data;
    if (data is Map<String, dynamic>) {
      final dynamic detail = data['detail'];
      if (detail is String && detail.trim().isNotEmpty) {
        return detail;
      }
    }
    if (error.type == DioExceptionType.connectionError) {
      return S.current.err_connection;
    }
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return S.current.err_timeout;
    }
    return fallback;
  }
}
