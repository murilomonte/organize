import 'package:drift/drift.dart';
import 'package:organize/src/data/database/app_database.dart';
import 'package:organize/src/data/database/tables/tasks.dart';

part 'tasks_dao.g.dart';

@DriftAccessor(tables: [Tasks])
class TasksDao extends DatabaseAccessor<AppDatabase> with _$TasksDaoMixin {
  TasksDao(super.db);

  // Create
  Future<int> createTask(TasksCompanion task) => into(tasks).insert(task);

  // Read
  Future<List<Task>> getAllTasks() => select(tasks).get();
  Future<List<Task>> getTask(int id) =>
      (select(tasks)..where((tbl) => tbl.id.equals(id))).get();

  // Update
  Future<int> updateTask(int id, TasksCompanion task) =>
      (update(tasks)..where((tbl) => tbl.id.equals(id))).write(task);

  // Delete
  Future<int> deleteTask(int id) =>
      (delete(tasks)..where((tbl) => tbl.id.equals(id))).go();
}
