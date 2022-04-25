import 'package:flutter/cupertino.dart';

import '../../../../models/audio_model.dart';

enum AudioRecordingsListStateStatus {
  initial,
  success,
  failed,
}

@immutable
class AudioRecordingsListState {
  const AudioRecordingsListState({
    this.status = AudioRecordingsListStateStatus.initial,
    this.loadedAudio,
  });
  // : assert(loadedAudio != null);
  final AudioRecordingsListStateStatus status;
  final Stream<List<AudioModel>>? loadedAudio;

  AudioRecordingsListState copyWith({
    AudioRecordingsListStateStatus? status,
    Stream<List<AudioModel>>? loadedAudio,
  }) {
    return AudioRecordingsListState(
      status: status ?? this.status,
      loadedAudio: loadedAudio ?? this.loadedAudio,
    );
  }
}
