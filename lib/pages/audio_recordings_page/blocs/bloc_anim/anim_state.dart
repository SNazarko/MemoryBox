part of 'anim_bloc.dart';

enum AudioRecordingsAnimStatus {
  open,
  close,
}

@immutable
class AudioRecordingsAnimState {
  const AudioRecordingsAnimState({
    this.status = AudioRecordingsAnimStatus.close,
    this.anim = 0.0,
  });

  final AudioRecordingsAnimStatus status;
  final double anim;

  AudioRecordingsAnimState copyWith(
      {AudioRecordingsAnimStatus? status, double? anim}) {
    return AudioRecordingsAnimState(
      status: status ?? this.status,
      anim: anim ?? this.anim,
    );
  }
}
