class Company {
  String id;
  String companyName;
  String industry;
  List<double> geolocation;
  String companyPhone;
  String companyEmail;
  String country;
  String state;
  String city;
  String street;
  String postalCode;
  String logoImage;

  // Constructor
  Company({
    required this.id,
    required this.companyName,
    required this.industry,
    required this.geolocation,
    required this.companyPhone,
    required this.companyEmail,
    required this.country,
    required this.state,
    required this.city,
    required this.street,
    required this.postalCode,
    required this.logoImage,
  });

  // Convert the object to a JSON format
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'companyName': companyName,
      'industry': industry,
      'geolocation': geolocation,
      'companyPhone': companyPhone,
      'companyEmail': companyEmail,
      'country': country,
      'state': state,
      'city': city,
      'street': street,
      'postalCode': postalCode,
      'logoImage': logoImage,
    };
  }

  // Create a Company object from a JSON format
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['_id'],
      companyName: json['companyName'],
      industry: json['industry'],
      geolocation:
          List<double>.from(json['geolocation'].map((x) => x.toDouble())),
      companyPhone: json['companyPhone'],
      companyEmail: json['companyEmail'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      street: json['street'],
      postalCode: json['postalCode'],
      logoImage: json['logoImage'],
    );
  }
}
