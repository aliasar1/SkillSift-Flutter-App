class User {
  String full;
  String email;
  String uid;
  String profilePhoto;
  String phone;
  String address;

  User({
    required this.full,
    required this.email,
    required this.uid,
    required this.profilePhoto,
    required this.phone,
    required this.address,
  });

  // Factory method to create a User object from a JSON string
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      full: json['full'],
      email: json['email'],
      uid: json['uid'],
      profilePhoto: json['profilePhoto'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  // Method to convert a User object to a JSON object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full'] = this.full;
    data['email'] = this.email;
    data['uid'] = this.uid;
    data['profilePhoto'] = this.profilePhoto;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}
