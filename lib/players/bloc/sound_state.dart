part of 'sound_bloc.dart';

@immutable
abstract class SoundState {}

class RecordsVisible extends SoundState {}

class PlayerVisible extends SoundState {}

class TimerState {
  final int duration;

  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}
