part of 'anim_bloc.dart';

@immutable
abstract class AudioRecordingsAnimEvent {}

class OpenAnimAudioRecordings extends AudioRecordingsAnimEvent {
  OpenAnimAudioRecordings({
    required this.anim,
  });
  final double anim;
}

class CloseAnimAudioRecordings extends AudioRecordingsAnimEvent {
  CloseAnimAudioRecordings({
    required this.anim,
  });
  final double anim;
}
