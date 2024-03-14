class Application {
  final String? id;
  final String jobId;
  final String jobseekerId;
  final String applicationStatus;
  final String currentLevel;
  final String cvUrl;

  Application({
    this.id,
    required this.jobId,
    required this.jobseekerId,
    required this.applicationStatus,
    required this.currentLevel,
    required this.cvUrl,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['_id'],
      jobId: json['job_id'],
      jobseekerId: json['jobseeker_id'],
      applicationStatus: json['application_status'],
      currentLevel: json['currentLevel'],
      cvUrl: json['cvUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_id': jobId,
      'jobseeker_id': jobseekerId,
      'application_status': applicationStatus,
      'currentLevel': currentLevel,
      'cvUrl': cvUrl,
    };
  }
}
