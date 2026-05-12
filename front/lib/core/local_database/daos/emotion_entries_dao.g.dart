// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emotion_entries_dao.dart';

// ignore_for_file: type=lint
mixin _$EmotionEntriesDaoMixin on DatabaseAccessor<AppDatabase> {
  $EmotionEntriesTable get emotionEntries => attachedDatabase.emotionEntries;
  EmotionEntriesDaoManager get managers => EmotionEntriesDaoManager(this);
}

class EmotionEntriesDaoManager {
  final _$EmotionEntriesDaoMixin _db;
  EmotionEntriesDaoManager(this._db);
  $$EmotionEntriesTableTableManager get emotionEntries =>
      $$EmotionEntriesTableTableManager(
        _db.attachedDatabase,
        _db.emotionEntries,
      );
}
