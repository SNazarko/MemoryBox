import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:memory_box/repositories/auth_repositories.dart';

import 'app_authorization_event.dart';
import 'app_authorization_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<PhoneNumberVerificationIdEvent>(
        (PhoneNumberVerificationIdEvent event, Emitter<AuthState> emit) async {
      emit(
        state.copyWith(status: AuthStatus.loading),
      );
      try {
        await AuthRepositories.instance.verifyPhoneSendOtp(event.phone!,
            completed: (credential) {
          print('completed');
          add(CompletedAuthEvent(credential: credential));
        }, failed: (error) {
          print(error);
          add(ErrorOccuredEvent(error: error.toString()));
        }, codeSent: (String id, int? token) {
          add(CodeSendEvent(token: token, verificationId: id));
        }, codeAutoRetrievalTimeout: (String id) {
          add(CodeSendEvent(verificationId: id, token: 0));
          // add(ErrorCodeSendEvent());
        });
      } on Exception catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
    on<ErrorCodeSendEvent>((ErrorCodeSendEvent event, Emitter<AuthState> emit) {
      emit(
        state.copyWith(
          status: AuthStatus.failedCodeSent,
        ),
      );
    });

    on<ErrorOccuredEvent>((ErrorOccuredEvent event, Emitter<AuthState> emit) {
      emit(
        state.copyWith(
          status: AuthStatus.failed,
        ),
      );
    });

    on<PhoneAuthCodeVerificationIdEvent>(
        (PhoneAuthCodeVerificationIdEvent event,
            Emitter<AuthState> emit) async {
      final uid = await AuthRepositories.instance.verifyAndLogin(
        event.verificationId!,
        event.smsCode!,
        event.phone!,
      );
      emit(
        state.copyWith(
          status: AuthStatus.logged,
          uid: uid,
        ),
      );
    });
    on<CodeSendEvent>((CodeSendEvent event, Emitter<AuthState> emit) {
      emit(
        state.copyWith(
          status: AuthStatus.codeSent,
          verificationId: event.verificationId,
          token: event.token,
        ),
      );
    });
  }

  //
  //   Stream<AuthState> mapEventToState(AuthState event) async* {
  //     if (event is PhoneNumberVerificationIdEvent) {
  //       yield* _phoneAuthVerificationToState(event);
  //     } else if (event is PhoneAuthCodeVerificationIdEvent) {
  //       final uid = awaid AuthRepositories.instance.verifyAndLogin(
  //           event.verificationId,
  //           event.smsCode,
  //           event.phone);
  //       yield LoggedInState(uid: uid);
  //     } else if (event is CodeSendEvent) {
  //       yield CodeSendState(
  //           verificationId: event.verificationId, token: event.token);
  //     }
  //   }
  //   Stream<AuthState>  _phoneAuthVerificationToState(PhoneNumberVerificationIdEvent event) async* {
  //     yield LoadingAuthState();
  //     await AuthRepositories.instance.verifyPhoneSendOtp(event.phone, completed: (credential)){
  //       print(completed);
  //       add(CompletedAuthEvent(credential: credential));
  //     },failed: (error){
  //       print(error);
  //       add( ErrorOccuredEvent(error: error.toString()));
  //     } codeSend: (String id, int? token){
  //       print('$id');
  //       add(CodeSendEvent(token: token, verificationId: id));
  //     }  codeAutoRetrievalTimeout: (id){
  //     print('$id');
  //     add(CodeSendEvent(verificationId: id, token: 0))
  //     }
  //     );
  //   }
  //
  //
  // }
//   <AppAuthorization>(event, emit) {
//     emit(state.copyWith(status: AppStatus.initial));
//   };
//
//   final User? authorization = _authenticationRepository.user;
//   if (authorization != null) {
//     emit(state.copyWith(status: AppStatus.authenticated));
//   } else {
//     emit(state.copyWith(status: AppStatus.unauthenticated));
//   }
// }
// //
// //   if(_authenticationRepository.user == null){
// //     on<AppAuthorization>(_onAppAuthorization);
//   }
//
//
//
//
//
// }
//
// final UserRepositories _authenticationRepository;
//
//
// void _onAppAuthorization(AppAuthorization event, Emitter<AppState> emit) {
//   _userSubscription = _authenticationRepository.readUser().listen(
//         (user) => add(AppUserChanged(user)),
//   );
//   emit(
//     event.user != null
//         ? AppState.authenticated(event.user)
//         : const AppState.unauthenticated(),
//   );
// }

// void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
//   unawaited(_authenticationRepository.logOut());
// }

// @override
// Future<void> close() {
//   _userSubscription.cancel();
//   return super.close();
// }
// }
}
