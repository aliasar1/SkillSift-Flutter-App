class CaseStudySession {
  String applicationId;
  String question;
  String response;
  DateTime startTime;

  CaseStudySession({
    required this.applicationId,
    required this.question,
    required this.response,
    required this.startTime,
  });

  factory CaseStudySession.fromJson(Map<String, dynamic> json) {
    return CaseStudySession(
      applicationId: json['application_id'],
      question: json['question'],
      response: json['response'],
      startTime: DateTime.parse(json['startTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'application_id': applicationId,
      'question': question,
      'response': response,
      'startTime': startTime.toIso8601String(),
    };
  }
}
