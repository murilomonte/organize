import 'package:drift/drift.dart';
import 'package:organize/src/data/database/app_database.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/data/database/tables/subtasks.dart';
import 'package:organize/src/data/database/tables/tasks.dart';

part 'status_dao.g.dart';

@DriftAccessor(tables: [Tasks, Subtasks])
class StatusDao extends DatabaseAccessor<AppDatabase> with _$StatusDaoMixin {
  StatusDao(super.db);

  Future<int> _getAllStatusCount(Status status) async {
    // Task
    final taskQuery = selectOnly(tasks)
      ..addColumns([tasks.id.count()])
      ..where(tasks.status.equals(status.name));

    int taskCount =
        await taskQuery.map((row) => row.read(tasks.id.count())).getSingle() ??
        0;

    // Subtask
    final subtaskQuery = selectOnly(subtasks)
      ..addColumns([subtasks.id.count()])
      ..where(subtasks.status.equals(status.name));

    int subtaskCount =
        await subtaskQuery
            .map((row) => row.read(subtasks.id.count()))
            .getSingle() ??
        0;

    // Subtask
    final groupQuery = selectOnly(groups)
      ..addColumns([groups.id.count()])
      ..where(groups.status.equals(status.name));

    int groupCount =
        await groupQuery
            .map((row) => row.read(groups.id.count()))
            .getSingle() ??
        0;

    return taskCount + subtaskCount + groupCount;
  }

  // completed
  Future<int> getCompletedCount() =>
      _getAllStatusCount(Status.completed);

  // pending
  Future<int> getPendingCount() => _getAllStatusCount(Status.pending);

  // inProgress
  Future<int> getInProgressount() => _getAllStatusCount(Status.inProgress);

  // total score
  Future<int> getTotalScore() async {
    final taskQuery = selectOnly(tasks)
      ..addColumns([tasks.score.sum()])
      ..where(tasks.status.equals(Status.completed.name));
    final taskScore =
        await taskQuery.map((row) => row.read(tasks.score.sum())).getSingle() ??
        0;

    final subtaskQuery = selectOnly(subtasks)
      ..addColumns([subtasks.score.sum()])
      ..where(subtasks.status.equals(Status.completed.name));
    final subtaskScore =
        await subtaskQuery
            .map((row) => row.read(subtasks.score.sum()))
            .getSingle() ??
        0;

    return taskScore + subtaskScore;
  }
}
