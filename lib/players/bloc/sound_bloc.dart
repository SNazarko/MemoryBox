import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../sound_record.dart';

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
      emit(Icon(Icons.pause_circle_filled));
    });
    on<RecordStop>((event, emit) {
      emit(Icon(Icons.mic_none));
    });
  }
}

// class TimerBloc extends Bloc<TimerEvent, TimerState> {
//   final Ticker _ticker;
//   static const int _duration = 60;
//
//   StreamSubscription<int>? _tickerSubscription;
//
//   TimerBloc({required Ticker ticker})
//       : _ticker = ticker,
//         super(TimerState(_duration)) {
//     on<TimerStarted>(_onStarted);
//     on<TimerPaused>(_onPaused);
//   }
//
//   @override
//   Future<void> close() {
//     _tickerSubscription?.cancel();
//     return super.close();
//   }
//
//   void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
//     emit(TimerState(event.duration));
//     _tickerSubscription?.cancel();
//     _tickerSubscription = _ticker
//         .tick(ticks: event.duration)
//         .listen((duration) => add(TimerStarted(duration: duration)));
//   }
//
//   void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
//     _tickerSubscription?.pause();
//     emit(TimerState(state.duration));
//   }
// }
