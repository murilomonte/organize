import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:organize/src/data/database/app_database.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/data/repositories/organize_repository.dart';
import 'package:organize/src/models/group_model.dart';
import 'package:organize/src/models/subtask_model.dart';
import 'package:organize/src/models/task_model.dart';

class GroupViewModel extends ChangeNotifier {
  final OrganizeRepository repo;

  List<GroupModel> _groupList = [];
  List<TaskModel> _taskList = [];
  List<SubtaskModel> _subtasklist = [];

  List<GroupModel> getGroupList() => _groupList;
  List<TaskModel> getTaskList(int groupId) => _taskList.where((e) => e.groupId == groupId).toList();
  List<SubtaskModel> getSubtaskList(int taskId) => _subtasklist.where((e) => e.taskId == taskId).toList();

  String errorMsg = '';
  bool isLoading = false;

  GroupViewModel({required this.repo}) {
    _updateLists();
  }

  void _updateLists() async {
    isLoading = true;
    notifyListeners();

    final groups = await repo.getAllGroups();
    switch (groups) {
      case Success(data: List<GroupModel> list):
        _groupList = list;
        break;

      case Failure(message: String message):
        errorMsg = message;
        break;
    }

    final tasks = await repo.getAllTasks();
    switch (tasks) {
      case Success(data: List<TaskModel> list):
        _taskList = list;
        break;

      case Failure(message: String message):
        errorMsg = message;
        break;
    }

    final subtasks = await repo.getAllSubtasks();
    switch (subtasks) {
      case Success(data: List<SubtaskModel> list):
        _subtasklist = list;
        break;

      case Failure(message: String message):
        errorMsg = message;
        break;
    }

    isLoading = false;
    notifyListeners();
  }

  void createGroup({
    required String title,
    required String? description,
  }) async {
    final result = await repo.createGroup(
      GroupsCompanion(title: Value(title), description: Value(description)),
    );

    switch (result) {
      case Success():
        break;

      case Failure(message: String message):
        errorMsg = message;
        break;
    }

    _updateLists();
  }

  void createTask({
    required int groupId,
    required String title,
    required String description,
    required int score,
  }) async {
    final result = await repo.createTask(
      TasksCompanion(
        group: Value(groupId),
        title: Value(title),
        description: Value(description),
        score: Value(score),
      ),
    );

    switch (result) {
      case Success():
        break;

      case Failure(message: String message):
        errorMsg = message;
        break;
    }

    _updateLists();
  }

  void createSubtask({
    required int taskId,
    required String title,
    required String description,
    required int score,
  }) async {
    final result = await repo.createSubtask(
      SubtasksCompanion(
        task: Value(taskId),
        title: Value(title),
        description: Value(description),
        score: Value(score),
      ),
    );

    switch (result) {
      case Success():
        break;

      case Failure(message: String message):
        errorMsg = message;
        break;
    }

    _updateLists();
  }

  void updateGroup({
    required int id,
    String? title,
    String? description,
    Status? status,
  }) async {
    final result = await repo.updateGroup(
      GroupsCompanion(
        id: Value(id),
        title: title != null ? Value(title) : Value.absent(),
        description: description != null ? Value(description) : Value.absent(),
        status: status != null ? Value(status) : Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );

    switch (result) {
      case Success():
        break;

      case Failure(message: String message):
        errorMsg = message;
        break;
    }

    _updateLists();
  }

  void updateTask({
    required int id,
    String? title,
    String? description,
    Status? status,
    int? score,
  }) async {
    final result = await repo.updateTask(
      TasksCompanion(
        id: Value(id),
        title: title != null ? Value(title) : Value.absent(),
        description: description != null ? Value(description) : Value.absent(),
        status: status != null ? Value(status) : Value.absent(),
        score: score != null ? Value(score) : Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );

    switch (result) {
      case Success():
        break;

      case Failure(message: String message):
        errorMsg = message;
        break;
    }

    _updateLists();
  }

  void updateSubtask({
    required int id,
    String? title,
    String? description,
    Status? status,
    int? score,
  }) async {
    final result = await repo.updateSubtask(
      SubtasksCompanion(
        id: Value(id),
        title: title != null ? Value(title) : Value.absent(),
        description: description != null ? Value(description) : Value.absent(),
        status: status != null ? Value(status) : Value.absent(),
        score: score != null ? Value(score) : Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );

    switch (result) {
      case Success():
        break;

      case Failure(message: String message):
        errorMsg = message;
        break;
    }

    _updateLists();
  }
}
