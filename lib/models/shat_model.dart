import 'package:cloud_firestore/cloud_firestore.dart';

class ShatModel {
  String? message;
  String? phoneNumber;
  Timestamp? dateTime;
  ShatModel({
    this.message,
    this.phoneNumber,
    this.dateTime,
  });
  factory ShatModel.fromJson(Map<String, dynamic> json) {
    return ShatModel(
      message: json['message'],
      phoneNumber: json['phoneNumber'],
      dateTime: json['dateTime'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'message': message, 'phoneNumber': phoneNumber, 'dateTime': dateTime};
}
