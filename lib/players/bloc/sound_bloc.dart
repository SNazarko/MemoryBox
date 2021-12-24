import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../sound_record.dart';
part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<PlayStop, SoundState> {
  SoundRecord soundRecord = SoundRecord();
  bool _play = false;
  bool _mPlayerIsInited = false;
  bool _mplaybackReady = false;
  bool isVisible = false;
  double height = 40;

  SoundBloc() : super(PlayerVisible()) {
    FutureOr<void> _playerPlay(event, emit) {
      emit(_play);
      _play = !_play;
      if (_play) {
        soundRecord.play(_mPlayerIsInited, _mplaybackReady);
      }
      if (!_play) {
        soundRecord.stopPlayer();
      }
    }

    on<PlayerPlayStop>(_playerPlay);
  }
}

// on<PlayerPlayStop>((event, emit) {
//   _play = !_play;
// });
// if (_play) {
//   soundRecord.play(_mPlayerIsInited, _mplaybackReady);
// }
// if (!_play) {
//   soundRecord.stopPlayer();
// }

//   on<RecordPlayStop>((event, emit) async {
//     emit(PlayerVisible());
//     _play = !_play;
//     if (_play) {
//       soundRecord.record();
//     }
//     if (!_play) {
//       soundRecord.stopRecorder(_mplaybackReady);
//       _mplaybackReady = true;
//     }
//     isVisible = !isVisible;
//     height = 15;
//   });

//   FutureOr<void> _playerPlay(event, emit) {
//     emit(soundRecord.play(_mPlayerIsInited, _mplaybackReady));
//   }
//
//   FutureOr<void> _playerStop(event, emit) {
//     emit(soundRecord.stopPlayer());
//   }
//
//   on<PlayerPlay>(_playerPlay);
//   on<PlayerStop>(_playerStop);
//   // _play = !_play;
//   // if (_play) {
//   //   soundRecord.play(_mPlayerIsInited, _mplaybackReady);
//   // }
//   // if (!_play) {
//   //   soundRecord.stopPlayer();
//   // }
//   // });
// }
