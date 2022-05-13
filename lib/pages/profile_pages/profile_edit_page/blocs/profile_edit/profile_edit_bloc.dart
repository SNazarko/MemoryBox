import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'profile_edit_event.dart';
part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  ProfileEditBloc() : super(const ProfileEditState()) {
    on<ProfileEditEvent>((event, emit) {
      emit(state.copyWith(
        userName: event.userName,
        phoneNumber: event.phoneNumber,
      ));
    });
  }
}
