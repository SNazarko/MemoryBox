import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'sound_event.dart';
part 'sound_state.dart';

class IconPlayPauseBloc extends Bloc<PlayStopEvent, Icon> {
  IconPlayPauseBloc() : super(Icon(Icons.play_circle_filled)) {
    on<PlayerPlay>((event, emit) {
      emit(Icon(Icons.pause_circle_filled));
    });
    on<PlayerStop>((event, emit) {
      emit(Icon(Icons.play_circle_filled));
    });
  }
}

class IconRecPlayPauseBloc extends Bloc<PlayStopEvent, Icon> {
  IconRecPlayPauseBloc() : super(Icon(Icons.mic_none)) {
    on<RecordPlay>((event, emit) {
      emit(Icon(Icons.mic_none));
    });
    on<RecordStop>((event, emit) {
      emit(Icon(Icons.pause_circle_filled));
    });
  }
}
