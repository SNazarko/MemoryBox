import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../sound_record.dart';
part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<RecPlayStop, SoundState> {
  SoundRecord soundRecord = SoundRecord();
  bool _play = false;
  bool _mplaybackReady = false;

  SoundBloc() : super(SoundVisible()) {
    on<RecordPlayStop>((event, emit) async {
      _play = !_play;
      if (_play) {
        soundRecord.record();
      }
      if (!_play) {
        soundRecord.stopRecorder(_mplaybackReady);
        _mplaybackReady = true;
      }
    });
    on<IconPlayStop>((event, emit) {
      _play ? const Icon(Icons.play_circle_filled) : const Icon(Icons.mic_none);
    });
  }
}
