class ScoreModel {
  int completedTasks;
  int nonCompletedTasks;
  int totalScore;

  ScoreModel({
    required this.completedTasks,
    required this.nonCompletedTasks,
    required this.totalScore,
  });

  @override
  String toString() {
    return '''
{
  "completedTasks": "$completedTasks",
  "nonCompletedTasks": "$nonCompletedTasks",
  "totalScore": "$totalScore",
}''';
  }

}