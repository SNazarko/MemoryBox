import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'recordings_page_event.dart';
part 'recordings_page_state.dart';

class RecordingsPageBloc
    extends Bloc<RecordingsPageEvent, RecordingsPageState> {
  RecordingsPageBloc()
      : super(
          const RecordingsPageState(),
        ) {
    on<RecordingsPageEvent>((
      event,
      emit,
    ) {
      emit(
        state.copyWith(
          path: event.path,
          minutes: event.minutes,
          seconds: event.seconds,
        ),
      );
    });
  }
}
