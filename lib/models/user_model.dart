class UserModel {
  String? displayName;
  String? phoneNumb;
  String? avatarUrl;
  String? totalTime;
  int? totalQuality;
  int? totalSize;
  String? subscription;

  UserModel({
    this.displayName,
    this.phoneNumb,
    this.avatarUrl,
    this.totalTime,
    this.totalQuality,
    this.totalSize,
    this.subscription,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      displayName: json['displayName'],
      phoneNumb: json['phoneNumb'],
      avatarUrl: json['avatarUrl'],
      totalTime: json['totalTime'],
      totalQuality: json['totalQuality'],
      totalSize: json['totalSize'],
      subscription: json['subscription'],
    );
  }

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'phoneNumb': phoneNumb,
        'avatarUrl': avatarUrl,
        'totalTime': totalTime,
        'totalQuality': totalQuality,
        'totalSize': totalSize,
        'subscription': subscription
      };
}
