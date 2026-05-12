import 'package:drift/drift.dart';

class EmotionEntries extends Table {

  TextColumn get id => text()();

  TextColumn get emotion => text()();

  IntColumn get intensity => integer()();

  TextColumn get activity => text().nullable()();

  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}