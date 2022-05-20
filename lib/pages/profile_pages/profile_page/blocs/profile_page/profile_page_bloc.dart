import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  ProfilePageBloc() : super(const ProfilePageState()) {
    on<ProfilePageEvent>((event, emit) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      emit(state.copyWith(
        name: event.name ?? sharedPreferences.getString('name_key'),
        number: event.number ?? sharedPreferences.getString('number_key'),
        image: event.image ?? sharedPreferences.getString('image_key'),
      ));
    });
  }
}
