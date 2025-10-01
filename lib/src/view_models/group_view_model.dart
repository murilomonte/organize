import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:organize/src/data/database/app_database.dart';
import 'package:organize/src/data/repositories/organize_repository.dart';
import 'package:organize/src/models/group_model.dart';

class GroupViewModel extends ChangeNotifier {
  final OrganizeRepository repo;

  List<GroupModel> groupList = [];
  String errorMsg = '';
  bool isLoading = false;

  GroupViewModel({required this.repo}) {
    _updateGroupList();
  }

  void _updateGroupList() async {
    errorMsg = '';
    isLoading = true;
    notifyListeners();

    final result = await repo.getAllGroupWithTasksAndSubtasks();
    switch (result) {
      case Success(data: List<GroupModel> list):
        groupList = list;
        break;

      case Failure(message: String message):
        errorMsg = message;
        break;
    }
    isLoading = false;
    notifyListeners();
  }

  void createGroup({required String title, required String description}) async {
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

    _updateGroupList();
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
    print(result);

    switch (result) {
      case Success():
        break;

      case Failure(message: String message):
        errorMsg = message;
        break;
    }

    _updateGroupList();
  }
}
