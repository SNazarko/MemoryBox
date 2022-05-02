part of 'app_authorization_bloc.dart';

enum AppStatus {
  initial,
  loading,
  success,
  failed,
  codeSent,
}

class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.initial,
    this.uid,
    this.verificationId,
    this.token,
  });

  final AppStatus status;
  final String? uid;
  final String? verificationId;
  final String? token;

  AppState copyWith({
    AppStatus? status,
    User? user,
    String? verificationId,
    String? token,
  }) {
    return AppState(
      status: status ?? this.status,
      verificationId: verificationId ?? this.verificationId,
      token: token ?? this.token,
    );
  }

  @override
  List<Object> get props => [uid!, status, token!, verificationId!];
}
