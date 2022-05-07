import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class PhoneNumberVerificationIdEvent extends AuthEvent {
  const PhoneNumberVerificationIdEvent({this.phone});
  final String? phone;
  @override
  List<Object?> get props => [phone];
}

class PhoneAuthCodeVerificationIdEvent extends AuthEvent {
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

class CompletedAuthEvent extends AuthEvent {
  const CompletedAuthEvent({this.credential});
  final AuthCredential? credential;
}

class ErrorOccuredEvent extends AuthEvent {
  ErrorOccuredEvent({this.error});
  final String? error;
}

class CodeSendEvent extends AuthEvent {
  const CodeSendEvent({
    this.token,
    this.verificationId,
  });
  final int? token;
  final String? verificationId;
}

class ErrorCodeSendEvent extends AuthEvent {
  ErrorCodeSendEvent({this.error});
  final String? error;
}
