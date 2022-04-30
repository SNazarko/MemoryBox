import 'package:flutter/cupertino.dart';

import '../../../../models/audio_model.dart';

@immutable
abstract class AudioRecordingsListEvent {}

class LoadAudioRecordingsListEvent extends AudioRecordingsListEvent {}

class UpdateAudioRecordingsListEvent extends AudioRecordingsListEvent {
  UpdateAudioRecordingsListEvent({
    this.loadedAudio = const <AudioModel>[],
  });
  final List<AudioModel> loadedAudio;
}
