class Company {
  String companyName;
  String industryOrSector;
  String companySize;
  String location;
  String contactNo;
  String contactEmail;
  String password;
  String companyLogo;
  bool termsAndConditionsAccepted;
  String street1;
  String state;
  String city;
  String country;
  String postalCode;

  // Constructor
  Company({
    required this.companyName,
    required this.industryOrSector,
    required this.companySize,
    required this.location,
    required this.contactNo,
    required this.contactEmail,
    required this.password,
    this.companyLogo = '',
    required this.termsAndConditionsAccepted,
    required this.street1,
    required this.state,
    required this.city,
    required this.country,
    required this.postalCode,
  });

  // Convert the object to a JSON format
  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'industryOrSector': industryOrSector,
      'companySize': companySize,
      'contactNumber': contactNo,
      'contactEmail': contactEmail,
      'password': password,
      'termsAndConditions': termsAndConditionsAccepted,
      'street1': street1,
      'state': state,
      'city': city,
      'country': country,
      'postalCode': postalCode,
      'location': location,
    };
  }

  // Create a CompanyRegistrationModel object from a JSON format
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyName: json['companyName'],
      industryOrSector: json['industryOrSector'],
      companySize: json['companySize'],
      contactNo: json['contactNumber'],
      contactEmail: json['contactEmail'],
      password: json['password'],
      termsAndConditionsAccepted: json['termsAndConditions'],
      street1: json['street1'],
      state: json['state'],
      city: json['city'],
      country: json['country'],
      postalCode: json['postalCode'],
      location: '',
    );
  }
}
