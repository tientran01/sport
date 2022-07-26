class UserInformation {
  String? displayName;
  String? email;
  String? photoUrl;
  String? uid;

  UserInformation({
    this.displayName,
    this.email,
    this.photoUrl,
    this.uid,
  });

  UserInformation.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'email': email,
        'photoUrl': photoUrl,
      };
}
