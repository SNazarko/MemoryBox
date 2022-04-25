import 'package:flutter/cupertino.dart';

import '../../../../models/audio_model.dart';

@immutable
abstract class AudioRecordingsListEvent {
  const AudioRecordingsListEvent({
    required this.loadedAudio,
  });
  final Stream<List<AudioModel>>? loadedAudio;
}
