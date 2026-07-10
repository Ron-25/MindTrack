import 'package:mind_track/features/emotion_tracker/domain/entities/emotion_entry.dart';

abstract class EmotionRepository {
  Future<List<EmotionEntry>> fetchEntries({int limit = 50});

  Future<EmotionEntry> fetchEntry(String id);

  Future<List<EmotionTypeOption>> fetchEmotionTypes();

  Future<List<EmotionTag>> fetchTags();

  Future<EmotionEntry> createEntry(CreateEmotionEntryInput input);

  Future<EmotionEntry> updateEntry(String id, UpdateEmotionEntryInput input);

  Future<void> deleteEntry(String id);
}
