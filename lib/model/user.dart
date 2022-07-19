class User {
  int? id;
  String? userName;
  String? gender;
  String? createdAt;
  String? updatedAt;
  String? email;
  String? jti;
  int? point;
  String? displayName;

  User({
    this.id,
    this.userName,
    this.gender,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.jti,
    this.point,
    this.displayName,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    gender = json['gender'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    email = json['email'];
    jti = json['jti'];
    point = json['point'];
    displayName = json['display_name'];
  }
}
