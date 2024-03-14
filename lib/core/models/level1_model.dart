class Level1 {
  final String? id;
  final String applicationId;
  final double score;
  final String status;

  Level1({
    this.id,
    required this.applicationId,
    required this.score,
    required this.status,
  });

  factory Level1.fromJson(Map<String, dynamic> json) {
    return Level1(
      id: json['_id'],
      applicationId: json['application_id'],
      score: json['score'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'application_id': applicationId,
      'score': score,
      'status': status,
    };
  }
}
