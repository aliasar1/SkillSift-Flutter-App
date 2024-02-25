class Recruiter {
  final String id;
  final String userId;
  final String fullname;
  final String contactNo;
  String? companyId;
  final List<dynamic> jobsAdded;
  final String profilePicUrl;
  final String email;

  Recruiter({
    required this.id,
    required this.userId,
    required this.fullname,
    required this.contactNo,
    required this.companyId,
    required this.jobsAdded,
    required this.profilePicUrl,
    required this.email,
  });

  factory Recruiter.fromJson(Map<String, dynamic> json) {
    return Recruiter(
      id: json['_id'],
      userId: json['user_id'],
      fullname: json['fullname'],
      contactNo: json['contact_no'],
      companyId: json['company_id'],
      jobsAdded: json['jobsAdded'],
      profilePicUrl: json['profilePicUrl'],
      email: json['email'],
    );
  }
}
