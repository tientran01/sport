class Users {
  String? displayName;
  String? email;
  String? photoUrl;
  String? uid;

  Users({
    this.displayName,
    this.email,
    this.photoUrl,
    this.uid,
  });

  Users.fromJson(Map<String, dynamic> json) 
    : displayName = json['displayName'],
      email = json['email'],
      photoUrl = json['photoUrl'],
      uid = json['uid'];

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'email': email,
        'photoUrl': photoUrl,
      };
}
