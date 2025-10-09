import 'package:drift/drift.dart';
import 'package:organize/src/data/database/status_enum.dart';

class Groups extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().withLength(max: 500).nullable()();
  TextColumn get status => textEnum<Status>().withDefault(Constant(Status.pending.name))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}