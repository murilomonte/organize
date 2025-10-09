class StatusModel {
  int completed;
  int pending;
  int inProgress;
  int totalScore;

  StatusModel({
    required this.completed,
    required this.pending,
    required this.inProgress,
    required this.totalScore,
  });

  @override
  String toString() {
    return '''
{
  "completed": "$completed",
  "pending": "$pending",
  "inProgress": "$inProgress",
  "totalScore": "$totalScore",
}''';
  }

}