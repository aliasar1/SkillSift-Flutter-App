class User {
  String fullName;
  String email;
  String uid;
  String profilePhoto;
  String phone;
  String address;

  User({
    required this.fullName,
    required this.email,
    required this.uid,
    required this.profilePhoto,
    required this.phone,
    required this.address,
  });

  // Factory method to create a User object from a JSON string
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      email: json['email'],
      uid: json['uid'],
      profilePhoto: json['profilePhoto'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  // Method to convert a User object to a JSON object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full'] = fullName;
    data['email'] = email;
    data['uid'] = uid;
    data['profilePhoto'] = profilePhoto;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }
}
