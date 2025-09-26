import 'package:organize/src/data/database/app_database.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/models/task_model.dart';

class GroupModel {
  final int id;
  final String title;
  final String? description;
  final Status status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<TaskModel> tasks;

  GroupModel({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.tasks,
  });

  @override
  String toString() {
    return '''
{
  "id": $id,
  "title": "$title",
  "description": ${description != null ? '"$description"' : null},
  "status": $status,
  "createdAt": "$createdAt",
  "updatedAt": "$updatedAt",
  "tasks": $tasks
}''';
  }

  GroupModel copywith({
    int? id,
    String? title,
    String? description,
    Status? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GroupModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      tasks: tasks,
    );
  }

  static GroupModel fromEntity(Group group) {
    return GroupModel(
      id: group.id,
      title: group.title,
      description: group.description,
      status: group.status,
      createdAt: group.createdAt,
      updatedAt: group.updatedAt,
      tasks: [],
    );
  }
}
