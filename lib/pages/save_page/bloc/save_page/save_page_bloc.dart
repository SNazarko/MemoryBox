import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'save_page_event.dart';
part 'save_page_state.dart';

class SavePageBloc extends Bloc<SavePageEvent, SavePageState> {
  SavePageBloc() : super(const SavePageState()) {
    on<SavePageEvent>((SavePageEvent event, Emitter<SavePageState> emit) {
      emit(state.copyWith(
        newAudioName: event.newAudioName,
        newSearchName: event.newSearchName,
      ));
    });
  }
}
