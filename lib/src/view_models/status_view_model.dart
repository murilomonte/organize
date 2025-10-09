import 'package:flutter/material.dart';
import 'package:organize/src/data/repositories/organize_repository.dart';
import 'package:organize/src/models/status_model.dart';

class StatusViewModel extends ChangeNotifier {
  StatusModel currentStatus = StatusModel(
    completed: 0,
    pending: 0,
    inProgress: 0,
    totalScore: 0,
  );

  final OrganizeRepository repo;

  StatusViewModel({required this.repo});

  String errorMsg = '';
  bool isLoading = false;

  void updateModel() async {
    isLoading = true;
    notifyListeners();

    final result = await repo.getStatus();
    switch (result) {
      case Success(data: StatusModel status):
        currentStatus = status;

      case Failure(message: String message):
        errorMsg = message;
        break;
    }

    isLoading = false;
    notifyListeners();
  }
}
