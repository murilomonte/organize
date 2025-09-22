import 'package:drift/drift.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/data/database/tables/tasks.dart';

class Subtasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get task => integer().references(Tasks, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().withLength(max: 500).nullable()();
  IntColumn get score => integer()();
  TextColumn get status => textEnum<Status>().withDefault(Constant(Status.pending.name))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
    'CHECK (score >= 0 AND score <= 100)',
  ];
}