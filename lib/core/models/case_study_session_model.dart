class CaseStudySession {
  String applicationId;
  String question;
  String response;
  DateTime startTime;
  String status;
  DateTime? submissionTime;

  CaseStudySession({
    required this.applicationId,
    required this.question,
    required this.response,
    required this.startTime,
    required this.status,
    this.submissionTime,
  });

  factory CaseStudySession.fromJson(Map<String, dynamic> json) {
    return CaseStudySession(
      applicationId: json['application_id'],
      question: json['question'],
      response: json['response'],
      startTime: DateTime.parse(json['startTime']),
      status: json['status'],
      submissionTime: json['submissionTime'] != null
          ? DateTime.parse(json['submissionTime'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'application_id': applicationId,
      'question': question,
      'response': response,
      'startTime': startTime.toIso8601String(),
      'status': status,
      'submissionTime': submissionTime?.toIso8601String(),
    };
  }
}
