import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'daos/daos.dart';
import 'tables/tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: <Type>[
    EmotionEntries,
    Habits,
  ],
  daos: <Type>[
    EmotionEntriesDao,
    HabitsDao,
  ],
)
class AppDatabase extends _$AppDatabase {

  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {

    final Directory dbFolder = await getApplicationDocumentsDirectory();

    final File file = File(p.join(dbFolder.path, 'mindtrack.sqlite'));

    return NativeDatabase(file);

  });
}