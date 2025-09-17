import 'package:drift/drift.dart';
import 'package:organize/src/data/database/tables/groups.dart';
import 'package:organize/src/data/database/status_enum.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get group => integer().references(Groups, #id)();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().withLength(min: 1, max: 500)();
  IntColumn get score => integer()();
  TextColumn get status => textEnum<Status>()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
