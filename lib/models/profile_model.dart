class ProfileModel {
  String? fullName;
  String? professionalTitle;
  String? bio;
  String? phoneNumber;
  String? email;
  String? address;
  String? website;
  String? linkedin;
  String? github;
  String? profileImagePath;

  ProfileModel({
    this.fullName,
    this.professionalTitle,
    this.bio,
    this.phoneNumber,
    this.email,
    this.address,
    this.website,
    this.linkedin,
    this.github,
    this.profileImagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'professionalTitle': professionalTitle,
      'bio': bio,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'website': website,
      'linkedin': linkedin,
      'github': github,
      'profileImagePath': profileImagePath,
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'],
      professionalTitle: json['professionalTitle'],
      bio: json['bio'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      address: json['address'],
      website: json['website'],
      linkedin: json['linkedin'],
      github: json['github'],
      profileImagePath: json['profileImagePath'],
    );
  }
}
