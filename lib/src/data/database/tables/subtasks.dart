import 'package:drift/drift.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/data/database/tables/tasks.dart';

class Subtasks extends Table {
  late final Column<int> id = integer().autoIncrement()();
  late final Column<int> task = integer().references(Tasks, #id)();
  late final Column<String> title = text().withLength(min: 1, max: 100)();
  late final Column<String> description = text().withLength(max: 500).nullable()();
  late final Column<int> score = integer().check(score.isSmallerOrEqualValue(100))();
  late final Column<String> status = textEnum<Status>().withDefault(Constant(Status.pending.name))();
  late final Column<DateTime> createdAt = dateTime().withDefault(currentDateAndTime)();
  late final Column<DateTime> updatedAt = dateTime().withDefault(currentDateAndTime)();
}
