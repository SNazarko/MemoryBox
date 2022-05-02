import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories/audio_repositories.dart';
import '../../repositories/user_repositories.dart';
import 'app_authorization_event.dart';

part 'app_authorization_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final UserRepositories _authenticationRepository;

  AppBloc({required UserRepositories authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const AppState()) {}
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
