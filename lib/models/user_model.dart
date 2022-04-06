import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? displayName;
  String? phoneNumb;
  String? avatarUrl;
  String? totalTime;
  int? totalQuality;
  int? totalSize;
  bool? subscription;
  Timestamp? dateTimeDelete;
  int? subscriptionLimit;
  bool? onceAMonth;
  bool? onceAYear;
  bool? onlyMonth;

  UserModel({
    this.displayName,
    this.phoneNumb,
    this.avatarUrl,
    this.totalTime,
    this.totalQuality,
    this.totalSize,
    this.subscription,
    this.dateTimeDelete,
    this.subscriptionLimit,
    this.onceAMonth,
    this.onceAYear,
    this.onlyMonth,
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
      dateTimeDelete: json['dateTimeDelete'],
      subscriptionLimit: json['subscriptionLimit'],
      onceAMonth: json['onceAMonth'],
      onceAYear: json['onceAYear'],
      onlyMonth: json['onlyMonth'],
    );
  }

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'phoneNumb': phoneNumb,
        'avatarUrl': avatarUrl,
        'totalTime': totalTime,
        'totalQuality': totalQuality,
        'totalSize': totalSize,
        'subscription': subscription,
        'dateTimeDelete': dateTimeDelete,
        'subscriptionLimit': subscriptionLimit,
        'onceAMonth': onceAMonth,
        'onceAYear': onceAYear,
        'onlyMonth': onlyMonth
      };
}
