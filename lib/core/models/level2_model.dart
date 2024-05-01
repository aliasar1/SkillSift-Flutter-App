class Level2 {
  final String? id;
  final String applicationId;
  final int score;
  final String status;
  final String qnaId;

  Level2({
    this.id,
    required this.applicationId,
    required this.score,
    required this.status,
    required this.qnaId,
  });

  factory Level2.fromJson(Map<String, dynamic> json) {
    return Level2(
      id: json['_id'],
      applicationId: json['application_id'],
      score: json['score'],
      status: json['status'],
      qnaId: json['qna_id'],
    );
  }
}
