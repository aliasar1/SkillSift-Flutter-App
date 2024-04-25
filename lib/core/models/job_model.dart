class Job {
  late String id;
  late String title;
  late String description;
  late List<String> skillTags;
  late String qualificationRequired;
  late String experienceRequired;
  late String mode;
  late String type;
  late String industry;
  late num minSalary;
  late num maxSalary;
  late String jdUrl;
  late String jdJsonUrl;
  late String status;
  late DateTime deadline;
  late String recruiterId;
  late DateTime timeStamp;

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.skillTags,
    required this.qualificationRequired,
    required this.experienceRequired,
    required this.mode,
    required this.type,
    required this.industry,
    required this.minSalary,
    required this.maxSalary,
    required this.jdUrl,
    required this.jdJsonUrl,
    required this.status,
    required this.deadline,
    required this.recruiterId,
    required this.timeStamp,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      skillTags: List<String>.from(json['skill_tags']),
      qualificationRequired: json['qualification_required'],
      experienceRequired: json['experience_required'],
      mode: json['mode'],
      type: json['type'],
      industry: json['industry'],
      minSalary: json['min_salary'],
      maxSalary: json['max_salary'],
      jdUrl: json['jdUrl'],
      jdJsonUrl: json['jdJsonUrl'],
      status: json['status'],
      deadline: DateTime.parse(json['deadline']),
      recruiterId: json['recruiter_id'],
      timeStamp: DateTime.parse(json['time_stamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'skill_tags': skillTags,
      'qualification_required': qualificationRequired,
      'experience_required': experienceRequired,
      'mode': mode,
      'type': type,
      'industry': industry,
      'min_salary': minSalary,
      'max_salary': maxSalary,
      'jdUrl': jdUrl,
      'jdJsonUrl': jdJsonUrl,
      'status': status,
      'deadline': deadline.toIso8601String(),
      'recruiter_id': recruiterId,
      'time_stamp': timeStamp.toIso8601String(),
    };
  }

  int daysSinceCreation() {
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(timeStamp);
    return difference.inDays;
  }

  String postedDaysAgo() {
    int days = daysSinceCreation();
    if (days == 0) {
      return 'Posted today';
    } else if (days == 1) {
      return 'Posted 1 day ago';
    } else {
      return 'Posted $days days ago';
    }
  }
}
