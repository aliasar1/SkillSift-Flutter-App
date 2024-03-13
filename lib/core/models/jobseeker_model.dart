class JobSeeker {
  final String id;
  final String userId;
  final String fullname;
  final String contactNo;
  final String email;
  final String profilePicUrl;

  JobSeeker({
    required this.id,
    required this.userId,
    required this.fullname,
    required this.contactNo,
    required this.email,
    required this.profilePicUrl,
  });

  factory JobSeeker.fromJson(Map<String, dynamic> json) {
    return JobSeeker(
      id: json['_id'],
      userId: json['user_id'],
      fullname: json['fullname'],
      contactNo: json['contact_no'],
      email: json['email'],
      profilePicUrl: json['profilePicUrl'],
    );
  }
}
