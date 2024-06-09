class InterviewSchedule {
  final String applicationId;
  final DateTime date;
  final String time;

  InterviewSchedule({
    required this.applicationId,
    required this.date,
    required this.time,
  });

  factory InterviewSchedule.fromJson(Map<String, dynamic> json) {
    return InterviewSchedule(
      applicationId: json['application_id'],
      date: DateTime.parse(json['date']),
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'application_id': applicationId,
      'date': date.toIso8601String(),
      'time': time,
    };
  }
}
