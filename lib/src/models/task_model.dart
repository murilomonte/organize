import 'package:organize/src/data/database/app_database.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/models/subtask_model.dart';

class TaskModel {
  final int? id;
  final int groupId;
  final String title;
  final int score;
  final Status status;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<SubtaskModel> subtasks;

  TaskModel({
    this.id,
    required this.groupId,
    required this.title,
    required this.score,
    required this.status,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.subtasks,
  });

  @override
  String toString() {
    return '''
{
  "id": $id,
  "groupId": $groupId,
  "title": "$title",
  "score": $score,
  "status": "$status",
  "description": ${description != null ? '"$description"' : null},
  "createdAt": "$createdAt",
  "updatedAt": "$updatedAt",
  "subtasks": $subtasks
}''';
  }

  TaskModel copywith({
    int? id,
    int? groupId,
    String? title,
    int? score,
    Status? status,
    String? description,
    DateTime? updatedAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      title: title ?? this.title,
      score: score ?? this.score,
      status: status ?? this.status,
      description: description ?? this.description,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      subtasks: subtasks,
    );
  }

  static TaskModel fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      groupId: task.group,
      title: task.title,
      score: task.score,
      status: task.status,
      createdAt: task.createdAt,
      updatedAt: task.updatedAt,
      subtasks: [],
    );
  }
}
