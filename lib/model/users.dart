class UserInformation {
  String? displayName;
  String? email;
  String? photoUrl;
  String? uid;
  String? phoneNumber;

  UserInformation({
    this.displayName,
    this.email,
    this.photoUrl,
    this.uid,
    this.phoneNumber,
  });

  UserInformation.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    photoUrl = json['photoUrl'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'email': email,
        'photoUrl': photoUrl,
        'phoneNumber': phoneNumber,
      };
}
