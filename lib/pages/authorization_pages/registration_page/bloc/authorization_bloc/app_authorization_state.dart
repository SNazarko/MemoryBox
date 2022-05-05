import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class LoadingAuthState extends AuthState {}

class LoggedInState extends AuthState {
  const LoggedInState({this.uid});
  final String? uid;
  List<Object> get props => [uid!];
}

class CodeSendState extends AuthState {
  const CodeSendState({
    this.token,
    this.verificationId,
  });
  final String? verificationId;
  final int? token;
}

// part of 'app_authorization_bloc.dart';
//
// enum AppStatus {
//   initial,
//   loading,
//   logged,
//   failed,
//   codeSent,
// }
//
// class AppState extends Equatable {
//   const AppState({
//     this.status = AppStatus.initial,
//     this.uid,
//     this.verificationId,
//     this.token,
//   });
//
//   final AppStatus status;
//   final String? uid;
//   final String? verificationId;
//   final String? token;
//
//   AppState copyWith({
//     AppStatus? status,
//     User? user,
//     String? verificationId,
//     String? token,
//   }) {
//     return AppState(
//       status: status ?? this.status,
//       verificationId: verificationId ?? this.verificationId,
//       token: token ?? this.token,
//     );
//   }
//
//   @override
//   List<Object> get props => [uid!, status, token!, verificationId!];
// }
