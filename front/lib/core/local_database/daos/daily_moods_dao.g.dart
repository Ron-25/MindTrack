// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_moods_dao.dart';

// ignore_for_file: type=lint
mixin _$DailyMoodsDaoMixin on DatabaseAccessor<AppDatabase> {
  $DailyMoodsTable get dailyMoods => attachedDatabase.dailyMoods;
  DailyMoodsDaoManager get managers => DailyMoodsDaoManager(this);
}

class DailyMoodsDaoManager {
  final _$DailyMoodsDaoMixin _db;
  DailyMoodsDaoManager(this._db);
  $$DailyMoodsTableTableManager get dailyMoods =>
      $$DailyMoodsTableTableManager(_db.attachedDatabase, _db.dailyMoods);
}
