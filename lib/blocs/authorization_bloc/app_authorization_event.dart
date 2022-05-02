import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
  @override
  List<Object?> get props => [];
}

class PhoneNumberVerificationIdEvent extends AppEvent {
  const PhoneNumberVerificationIdEvent({this.phone});
  final String? phone;
  @override
  List<Object?> get props => [phone];
}

class PhoneAuthCodeVerificationIdEvent extends AppEvent {
  const PhoneAuthCodeVerificationIdEvent({
    this.phone,
    this.smsCode,
    this.verificationId,
  });
  final String? phone;
  final String? smsCode;
  final String? verificationId;
  @override
  List<Object?> get props => [phone, smsCode, verificationId];
}
