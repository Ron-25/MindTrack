import 'package:mind_track/features/emotion_tracker/data/datasources/emotion_remote_data_source.dart';
import 'package:mind_track/features/emotion_tracker/domain/entities/emotion_entry.dart';
import 'package:mind_track/features/emotion_tracker/domain/repositories/emotion_repository.dart';

class EmotionRepositoryImpl implements EmotionRepository {
  const EmotionRepositoryImpl(this._dataSource);

  final EmotionRemoteDataSource _dataSource;

  @override
  Future<List<EmotionEntry>> fetchEntries({int limit = 50}) {
    return _dataSource.fetchEntries(limit: limit);
  }

  @override
  Future<EmotionEntry> fetchEntry(String id) {
    return _dataSource.fetchEntry(id);
  }

  @override
  Future<List<EmotionTypeOption>> fetchEmotionTypes() {
    return _dataSource.fetchEmotionTypes();
  }

  @override
  Future<List<EmotionTag>> fetchTags() {
    return _dataSource.fetchTags();
  }

  @override
  Future<EmotionEntry> createEntry(CreateEmotionEntryInput input) {
    return _dataSource.createEntry(input);
  }

  @override
  Future<void> deleteEntry(String id) {
    return _dataSource.deleteEntry(id);
  }
}
