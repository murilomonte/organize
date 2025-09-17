import 'package:drift/drift.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/data/database/tables/tasks.dart';

class Subtasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get task => integer().references(Tasks, #id)();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().withLength(min: 1, max: 500)();
  IntColumn get score => integer()();
  TextColumn get status => textEnum<Status>()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
