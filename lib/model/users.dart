class Users {
  String? displayName;
  String? email;
  String? photoUrl;
  String? token;
  String? uid;

  Users({
    this.displayName,
    this.email,
    this.photoUrl,
    this.token,
    this.uid,
  });

  Users fromJson(Map<String, dynamic> json) {
    return Users(
      displayName: json[displayName],
      email: json[email],
      photoUrl: json[photoUrl],
      token: json[token],
      uid: json[uid],
    );
  }

  Map<String, dynamic> toJson(Users user) => {
        'displayName': user.displayName,
        'email': user.email,
        'photoUrl': user.photoUrl,
        'token': user.token,
      };
}
