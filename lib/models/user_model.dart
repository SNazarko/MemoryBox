class UserModel {
  String? displayName;
  String? phoneNumb;
  String? avatarUrl;

  UserModel({
    this.displayName,
    this.phoneNumb,
    this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      displayName: json['displayName'],
      phoneNumb: json['phoneNumb'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'phoneNumb': phoneNumb,
        'avatarUrl': avatarUrl
      };
}
