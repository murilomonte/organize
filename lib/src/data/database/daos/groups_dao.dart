import 'package:drift/drift.dart';
import 'package:organize/src/data/database/app_database.dart';
import 'package:organize/src/data/database/tables/groups.dart';

part 'groups_dao.g.dart';

@DriftAccessor(tables: [Groups])
class GroupsDao extends DatabaseAccessor<AppDatabase> with _$GroupsDaoMixin {
  GroupsDao(super.db);
  
  // Create
  Future<int> createGroup(GroupsCompanion group) => into(groups).insert(group);
  
  // Read
  Future<List<Group>> getAllGroups() => select(groups).get();
  Future<List<Group>> getGroup(int id) =>
      (select(groups)..where((tbl) => tbl.id.equals(id))).get();

  // Update
  Future<int> updateGroup(int id, GroupsCompanion group) =>
      (update(groups)..where((tbl) => tbl.id.equals(id))).write(group);

  // Delete
  Future<int> deleteGroup(int id) => (delete(groups)..where((tbl) => tbl.id.equals(id))).go();
}
