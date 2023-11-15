class Recruiter {
  String fullName;
  String email;
  String uid;
  String companyId;
  String employeeId;
  String profilePhoto;
  String phone;
  String role;
  bool isPassChanged;

  Recruiter({
    required this.fullName,
    required this.email,
    required this.uid,
    required this.companyId,
    required this.employeeId,
    required this.profilePhoto,
    required this.phone,
    required this.role,
    required this.isPassChanged,
  });

  // Factory method to create a User object from a JSON string
  factory Recruiter.fromJson(Map<String, dynamic> json) {
    return Recruiter(
      fullName: json['fullName'],
      email: json['email'],
      uid: json['uid'],
      companyId: json['companyId'],
      employeeId: json['employeeId'],
      profilePhoto: json['profilePhoto'],
      phone: json['phone'],
      role: json['role'],
      isPassChanged: json['isPassChanged'],
    );
  }

  // Method to convert a User object to a JSON object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full'] = fullName;
    data['email'] = email;
    data['uid'] = uid;
    data['companyId'] = companyId;
    data['employeeId'] = employeeId;
    data['profilePhoto'] = profilePhoto;
    data['phone'] = phone;
    data['role'] = role;
    data['isPassChanged'] = isPassChanged;
    return data;
  }
}
