import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bloc_all_event.dart';
part 'bloc_all_state.dart';

class PlayAllRepeatBloc extends Bloc<PlayAllRepeatEvent, Color> {
  PlayAllRepeatBloc() : super(const Color(0xFFF6F6F6)) {
    on<PlayAllEvent>((event, emit) {
      emit(const Color(0xFFF6F6F6));
    });
    on<RepeatEvent>((event, emit) {
      emit(const Color(0xFF7789C8));
    });
  }
}
