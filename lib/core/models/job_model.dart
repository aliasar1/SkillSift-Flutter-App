class Job {
  late String jobId;
  late String jobTitle;
  late String jobDescription;
  late List<String> skillsRequired;
  late String qualificationRequired;
  late String mode;
  late String industry;
  late String minSalary;
  late String maxSalary;
  late String jobAddedBy;
  late DateTime creationDateTime;
  late String jobType;
  late String experienceReq;
  late String companyId;
  late String jdUrl;

  Job({
    required this.jobId,
    required this.jobTitle,
    required this.jobDescription,
    required this.skillsRequired,
    required this.qualificationRequired,
    required this.mode,
    required this.industry,
    required this.minSalary,
    required this.maxSalary,
    required this.jobAddedBy,
    required this.creationDateTime,
    required this.jobType,
    required this.experienceReq,
    required this.companyId,
    required this.jdUrl,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      jobId: json['jobId'],
      jobTitle: json['jobTitle'],
      jobDescription: json['jobDescription'],
      skillsRequired: List<String>.from(json['skillsRequired']),
      qualificationRequired: json['qualificationRequired'],
      mode: json['mode'],
      industry: json['industry'],
      minSalary: json['minSalary'],
      maxSalary: json['maxSalary'],
      jobAddedBy: json['jobAddedBy'],
      creationDateTime: (json['creationDateTime']).toDate(),
      jobType: json['jobType'],
      experienceReq: json['experienceReq'],
      companyId: json['companyId'],
      jdUrl: json['jdUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobId': jobId,
      'jobTitle': jobTitle,
      'jobDescription': jobDescription,
      'skillsRequired': skillsRequired,
      'qualificationRequired': qualificationRequired,
      'mode': mode,
      'industry': industry,
      'minSalary': minSalary,
      'maxSalary': maxSalary,
      'jobAddedBy': jobAddedBy,
      'creationDateTime': creationDateTime,
      'jobType': jobType,
      'experienceReq': experienceReq,
      'companyId': companyId,
      'jdUrl': jdUrl,
    };
  }

  int daysSinceCreation() {
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(creationDateTime);
    return difference.inDays;
  }

  String postedDaysAgo() {
    int days = daysSinceCreation();

    if (days == 0 || days == 1) {
      return 'Posted 1 day ago';
    } else {
      return 'Posted $days days ago';
    }
  }
}
