import 'package:flutter/cupertino.dart';

import '../../../../models/audio_model.dart';

enum AudioRecordingsListStateStatus { initial, success, failed, }

@immutable
class AudioRecordingsListState {
  const AudioRecordingsListState({
    this.status = AudioRecordingsListStateStatus.initial,
    this.loadedAudio = const <AudioModel>[],
  });
  final AudioRecordingsListStateStatus status;
  final List<AudioModel> loadedAudio;

  AudioRecordingsListState copyWith({
    AudioRecordingsListStateStatus? status,
    List<AudioModel>? loadedAudio,
  }) {
    return AudioRecordingsListState(
      status: status ?? this.status,
      loadedAudio: loadedAudio ?? this.loadedAudio,
    );
  }
}
