import 'jobseeker_model.dart';
import 'recruiter_model.dart';

class User {
  final String token;
  final String role;
  final Recruiter? recruiter;
  final JobSeeker? jobseeker;

  User({
    required this.token,
    required this.role,
    this.recruiter,
    this.jobseeker,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    if (json['role'] == 'Recruiter') {
      return User(
        token: json['token'],
        role: json['role'],
        recruiter: Recruiter.fromJson(json['recruiter']),
      );
    } else {
      return User(
        token: json['token'],
        role: json['role'],
        jobseeker: JobSeeker.fromJson(json['jobseeker']),
      );
    }
  }
}
