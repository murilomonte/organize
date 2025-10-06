import 'package:organize/src/data/database/app_database.dart';
import 'package:organize/src/data/database/daos/groups_dao.dart';
import 'package:organize/src/data/database/daos/status_dao.dart';
import 'package:organize/src/data/database/daos/subtasks_dao.dart';
import 'package:organize/src/data/database/daos/tasks_dao.dart';
import 'package:organize/src/models/group_model.dart';
import 'package:organize/src/models/status_model.dart';
import 'package:organize/src/models/subtask_model.dart';
import 'package:organize/src/models/task_model.dart';

sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  Success(this.data);
}

class Failure<T> extends Result<T> {
  final String message;
  Failure(this.message);
}

class OrganizeRepository {
  final GroupsDao groupsDao;
  final TasksDao tasksDao;
  final SubtasksDao subtasksDao;
  final StatusDao statusDao;

  OrganizeRepository({
    required this.groupsDao,
    required this.tasksDao,
    required this.subtasksDao,
    required this.statusDao,
  }); 

  Future<Result<List<GroupModel>>> getAllGroups() async {
    try {
      List<GroupModel> result = [];
      List<Group> groups = await groupsDao.getAllGroups();

      for (var group in groups) {
        GroupModel groupModel = GroupModel.fromEntity(group);
        result.add(groupModel);
      }

      return Success(result);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<List<TaskModel>>> getAllTasks() async {
    try {
      List<TaskModel> result = [];
      List<Task> tasks = await tasksDao.getAllTasks();

      for (var task in tasks) {
        TaskModel groupModel = TaskModel.fromEntity(task);
        result.add(groupModel);
      }

      return Success(result);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<List<SubtaskModel>>> getAllSubtasks() async {
    try {
      List<SubtaskModel> result = [];
      List<Subtask> subtasks = await subtasksDao.getAllSubtasks();

      for (var subtask in subtasks) {
        SubtaskModel groupModel = SubtaskModel.fromEntity(subtask);
        result.add(groupModel);
      }

      return Success(result);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> createGroup(GroupsCompanion group) async {
    try {
      int id = await groupsDao.createGroup(group);
      return Success(id);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> createTask(TasksCompanion task) async {
    try {
      int id = await tasksDao.createTask(task);
      return Success(id);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> createSubtask(SubtasksCompanion subtask) async {
    try {
      int id = await subtasksDao.createSubtask(subtask);
      return Success(id);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> updateGroup(GroupsCompanion group) async {
    try {
      int id = await groupsDao.updateGroup(group.id.value, group);
      return Success(id);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> updateTask(TasksCompanion task) async {
    try {
      int id = await tasksDao.updateTask(task.id.value, task);
      return Success(id);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> updateSubtask(SubtasksCompanion subtask) async {
    try {
      int id = await subtasksDao.updateSubtask(subtask.id.value, subtask);
      return Success(id);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> deleteGroup(int id) async {
    try {
      int result = await groupsDao.deleteGroup(id);
      return Success(result);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> deleteTask(int id) async {
    try {
      int result = await tasksDao.deleteTask(id);
      return Success(result);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> deleteSubtask(int id) async {
    try {
      int result = await subtasksDao.deleteSubtask(id);
      return Success(result);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<StatusModel>> getStatus() async {
    try {
      int completedCount = await statusDao.getCompletedCount();
      int pendingCount = await statusDao.getPendingCount();
      int totalScore = await statusDao.getTotalScore();

      StatusModel result = StatusModel(
        completed: completedCount,
        pending: pendingCount,
        totalScore: totalScore,
      );

      return Success(result);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }
}
