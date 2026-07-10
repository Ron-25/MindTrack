import 'package:drift/drift.dart';

class Habits extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  BoolColumn get completed =>
      boolean().withDefault(const Constant<bool>(false))();

  DateTimeColumn get date => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
