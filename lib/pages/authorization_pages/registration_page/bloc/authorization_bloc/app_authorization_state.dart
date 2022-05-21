enum AuthStatus {
  initial,
  loading,
  logged,
  codeSent,
  failedCodeSent,
  failed,
}

class AuthState {
  const AuthState({
    this.status = AuthStatus.initial,
    this.uid,
    this.verificationId,
    this.token,
  });
  final AuthStatus status;
  final String? uid;
  final String? verificationId;
  final int? token;

  AuthState copyWith({
    AuthStatus? status,
    String? uid,
    String? verificationId,
    int? token,
  }) {
    return AuthState(
      status: status ?? this.status,
      uid: uid ?? this.uid,
      verificationId: verificationId ?? this.verificationId,
      token: token ?? this.token,
    );
  }
}
