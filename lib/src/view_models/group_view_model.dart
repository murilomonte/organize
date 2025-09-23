import 'package:flutter/material.dart';
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
}
