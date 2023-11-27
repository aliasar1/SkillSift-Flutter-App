class Job {
  late String jobId;
  late String jobTitle;
  late String jobDescription;
  late List<String> skillsRequired;
  late String qualificationRequired;
  late String mode;
  late String industry;
  late String companyUID;
  late double minSalary;
  late double maxSalary;

  Job({
    required this.jobId,
    required this.jobTitle,
    required this.jobDescription,
    required this.skillsRequired,
    required this.qualificationRequired,
    required this.mode,
    required this.industry,
    required this.companyUID,
    required this.minSalary,
    required this.maxSalary,
  });

  // Convert the object to a map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'jobId': jobId,
      'jobTitle': jobTitle,
      'jobDescription': jobDescription,
      'skillsRequired': skillsRequired,
      'qualificationRequired': qualificationRequired,
      'mode': mode,
      'industry': industry,
      'companyUID': companyUID,
      'minSalary': minSalary,
      'maxSalary': maxSalary,
    };
  }

  // Create a Job object from a map
  factory Job.fromMap(String jobId, Map<String, dynamic> map) {
    return Job(
      jobId: jobId,
      jobTitle: map['jobTitle'],
      jobDescription: map['jobDescription'],
      skillsRequired: List<String>.from(map['skillsRequired']),
      qualificationRequired: map['qualificationRequired'],
      mode: map['mode'],
      industry: map['industry'],
      companyUID: map['companyUID'],
      minSalary: map['minSalary'],
      maxSalary: map['maxSalary'],
    );
  }
}
