import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:memory_box/repositories/auth_repositories.dart';

import 'app_authorization_event.dart';
import 'app_authorization_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(
          const AuthState(),
        ) {
    on<PhoneNumberVerificationIdEvent>((
      PhoneNumberVerificationIdEvent event,
      Emitter<AuthState> emit,
    ) async {
      emit(
        state.copyWith(
          status: AuthStatus.loading,
        ),
      );
      try {
        await AuthRepositories.instance.verifyPhoneSendOtp(event.phone!,
            completed: (credential) {
          if (kDebugMode) {
            print('completed');
          }
          add(
            CompletedAuthEvent(credential: credential),
          );
        }, failed: (error) {
          if (kDebugMode) {
            print(error);
          }
          add(
            ErrorOccurredEvent(
              error: error.toString(),
            ),
          );
        }, codeSent: (
          String id,
          int? token,
        ) {
          add(
            CodeSendEvent(
              token: token,
              verificationId: id,
            ),
          );
        }, codeAutoRetrievalTimeout: (String id) {
          if (AuthRepositories.instance.user == null) {
            add(
              ErrorCodeSendEvent(),
            );
          }
        });
      } on Exception catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
    on<ErrorCodeSendEvent>((
      ErrorCodeSendEvent event,
      Emitter<AuthState> emit,
    ) {
      emit(
        state.copyWith(
          status: AuthStatus.failedCodeSent,
        ),
      );
    });

    on<ErrorOccurredEvent>((
      ErrorOccurredEvent event,
      Emitter<AuthState> emit,
    ) {
      emit(
        state.copyWith(
          status: AuthStatus.failed,
        ),
      );
    });

    on<PhoneAuthCodeVerificationIdEvent>(
        (PhoneAuthCodeVerificationIdEvent event,
            Emitter<AuthState> emit) async {
      try {
        await AuthRepositories.instance.verifyAndLogin(
          event.verificationId!,
          event.smsCode!,
          event.phone!,
        );
      } on Exception {
        add(
          ErrorCodeSendEvent(),
        );
      }
    });
    on<CodeSendEvent>((
      CodeSendEvent event,
      Emitter<AuthState> emit,
    ) {
      emit(
        state.copyWith(
          status: AuthStatus.codeSent,
          verificationId: event.verificationId,
          token: event.token,
        ),
      );
    });
  }
}
