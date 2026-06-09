import 'package:drift/drift.dart';

class DailyMoods extends Table {
  TextColumn get id => text()();
  TextColumn get mood => text()();
  TextColumn get note => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
