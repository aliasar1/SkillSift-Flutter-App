import 'recruiter_model.dart';

class User {
  final String token;
  final String role;
  final Recruiter recruiter;

  User({
    required this.token,
    required this.role,
    required this.recruiter,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
      role: json['role'],
      recruiter: Recruiter.fromJson(json['recruiter']),
    );
  }
}
