import 'package:drift/drift.dart';

class Groups extends Table {
  late final Column<int> id = integer().autoIncrement()();
  late final Column<String> title = text().withLength(min: 1, max: 100)();
  late final Column<String> description = text().withLength(max: 500).nullable()();
  late final Column<bool> isCompleted = boolean().withDefault(Constant(false))();
  late final Column<DateTime> createdAt = dateTime().withDefault(currentDateAndTime)();
  late final Column<DateTime> updatedAt = dateTime().withDefault(currentDateAndTime)();
}