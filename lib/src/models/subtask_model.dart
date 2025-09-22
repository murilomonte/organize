import 'package:organize/src/data/database/app_database.dart';
import 'package:organize/src/data/database/status_enum.dart';

class SubtaskModel {
  final int? id;
  final int taskId;
  final String title;
  final int score;
  final Status status;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubtaskModel({
    this.id,
    required this.taskId,
    required this.title,
    required this.score,
    required this.status,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  // toString
  @override
  String toString() {
    return '''
{
  "id": $id,
  "taskId": $taskId,
  "title": "$title",
  "score": $score,
  "status": "$status",
  "description": ${description != null ? '"$description"' : null},
  "createdAt": "$createdAt",
  "updatedAt": "$updatedAt"
}''';
  }

  SubtaskModel copywith({
    int? id,
    int? taskId,
    String? title,
    int? score,
    Status? status,
    String? description,
    DateTime? updatedAt,
  }) {
    return SubtaskModel(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      score: score ?? this.score,
      status: status ?? this.status,
      description: description ?? this.description,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  static SubtaskModel fromEntity(Subtask subtask) {
    return SubtaskModel(
      id: subtask.id,
      taskId: subtask.task,
      title: subtask.title,
      score: subtask.score,
      status: subtask.status,
      createdAt: subtask.createdAt,
      updatedAt: subtask.updatedAt,
    );
  }
}
