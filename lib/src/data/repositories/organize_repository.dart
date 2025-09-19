import 'package:organize/src/data/database/app_database.dart';
import 'package:organize/src/data/database/daos/groups_dao.dart';
import 'package:organize/src/data/database/daos/subtasks_dao.dart';
import 'package:organize/src/data/database/daos/tasks_dao.dart';
import 'package:organize/src/models/group_model.dart';
import 'package:organize/src/models/subtask_model.dart';
import 'package:organize/src/models/task_model.dart';

sealed class Result<T> {
  const Result();
}

class Sucess<T> extends Result<T> {
  final T data;
  Sucess(this.data);
}

class Failure<T> extends Result<T> {
  final String message;
  Failure(this.message);
}

class OrganizeRepository {
  final GroupsDao groupsDao;
  final TasksDao tasksDao;
  final SubtasksDao subtasksDao;

  OrganizeRepository({
    required this.groupsDao,
    required this.tasksDao,
    required this.subtasksDao,
  });

  Future<Result<List<GroupModel>>> getAllGroupWithTasksAndSubtasks() async {
    // TODO: melhorar tratamento de erro
    try {
      List<GroupModel> result = [];

      List<Group> groups = await groupsDao.getAllGroups();
      List<Task> tasks = await tasksDao.getAllTasks();
      List<Subtask> subtasks = await subtasksDao.getAllSubtasks();

      for (var group in groups) {
        GroupModel groupModel = GroupModel.fromEntity(group);

        tasks.where((element) => element.group == group.id).forEach((task) {
          TaskModel taskModel = TaskModel.fromEntity(task);

          subtasks.where((element) => element.task == task.id).forEach((
            subtask,
          ) {
            SubtaskModel subtaskModel = SubtaskModel.fromEntity(subtask);
            taskModel.subtasks.add(subtaskModel);
          });

          groupModel.tasks.add(taskModel);
        });

        result.add(groupModel);
      }

      return Sucess(result);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> createGroup(GroupsCompanion group) async {
    try {
      int id = await groupsDao.createGroup(group);
      return Sucess(id);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> createTask(TasksCompanion task) async {
    try {
      int id = await tasksDao.createTask(task);
      return Sucess(id);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> createSubtask(SubtasksCompanion subtask) async {
    try {
      int id = await subtasksDao.createSubtask(subtask);
      return Sucess(id);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> updateGroup(GroupsCompanion group) async {
    try {
      int id = await groupsDao.updateGroup(group.id.value, group);
      return Sucess(id);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> updateTask(TasksCompanion task) async {
    try {
      int id = await tasksDao.updateTask(task.id.value, task);
      return Sucess(id);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> updateSubtask(SubtasksCompanion subtask) async {
    try {
      int id = await subtasksDao.updateSubtask(subtask.id.value, subtask);
      return Sucess(id);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> deleteGroup(int id) async {
    try {
      int result = await groupsDao.deleteGroup(id);
      return Sucess(result);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> deleteTask(int id) async {
    try {
      int result = await tasksDao.deleteTask(id);
      return Sucess(result);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  Future<Result<int>> deleteSubtask(int id) async {
    try {
      int result = await subtasksDao.deleteSubtask(id);
      return Sucess(result);
    } catch (err) {
      return Failure("Unexpected error: $err");
    }
  }

  //TODO - Metodo para consultar a quantidade total de tarefas feitas (tasks e subtasks) e a quantidade de pontos obtidos.
}
