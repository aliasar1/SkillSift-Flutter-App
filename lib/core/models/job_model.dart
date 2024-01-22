import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory Job.fromMap(String jobId, Map<String, dynamic> map) {
    return Job(
      jobId: jobId,
      jobTitle: map['jobTitle'],
      jobDescription: map['jobDescription'],
      skillsRequired: List<String>.from(map['skillsRequired']),
      qualificationRequired: map['qualificationRequired'],
      mode: map['mode'],
      industry: map['industry'],
      minSalary: map['minSalary'].toString(),
      maxSalary: map['maxSalary'].toString(),
      jobAddedBy: map['jobAddedBy'],
      creationDateTime: (map['creationDateTime'] as Timestamp).toDate(),
      jobType: map['jobType'],
      experienceReq: map['experienceReq'],
      companyId: map['companyId'],
      jdUrl: map['jdUrl'],
    );
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
