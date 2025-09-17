import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:organize/src/data/database/daos/groups_dao.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/data/database/tables/groups.dart';
import 'package:organize/src/data/database/tables/subtasks.dart';
import 'package:organize/src/data/database/tables/tasks.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Groups, Tasks, Subtasks], daos: [GroupsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());
  
  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'organizedb',
      native: DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory
      )
    );
  }
}
