class StatusModel {
  int completed;
  int pending;
  int totalScore;

  StatusModel({
    required this.completed,
    required this.pending,
    required this.totalScore,
  });

  @override
  String toString() {
    return '''
{
  "completed": "$completed",
  "pending": "$pending",
  "totalScore": "$totalScore",
}''';
  }

}