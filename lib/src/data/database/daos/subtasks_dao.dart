import 'package:drift/drift.dart';
import 'package:organize/src/data/database/app_database.dart';
import 'package:organize/src/data/database/tables/subtasks.dart';

part 'subtasks_dao.g.dart';

@DriftAccessor(tables: [Subtasks])
class SubtasksDao extends DatabaseAccessor<AppDatabase> with _$SubtasksDaoMixin {
  SubtasksDao(super.db);
  
  // Create
  Future<int> createSubtask(SubtasksCompanion subtask) => into(subtasks).insert(subtask);
  
  // Read
  Future<List<Subtask>> getAllSubtasks() => select(subtasks).get();
  Future<List<Subtask>> getSubtask(int id) =>
      (select(subtasks)..where((tbl) => tbl.id.equals(id))).get();

  // Update
  Future<int> updateSubtask(int id, SubtasksCompanion subtask) =>
      (update(subtasks)..where((tbl) => tbl.id.equals(id))).write(subtask);

  // Delete
  Future<int> deleteSubtask(int id) => (delete(subtasks)..where((tbl) => tbl.id.equals(id))).go();

}
