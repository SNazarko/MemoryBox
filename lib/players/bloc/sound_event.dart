part of 'sound_bloc.dart';

abstract class PlayStopEvent {}

class RecordPlay extends PlayStopEvent {}

class RecordStop extends PlayStopEvent {}

class PlayerPlay extends PlayStopEvent {}

class PlayerStop extends PlayStopEvent {}

abstract class TimerEvent {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStarted extends TimerEvent {
  const TimerStarted({required this.duration});
  final int duration;
}

class TimerPaused extends TimerEvent {
  const TimerPaused();
}
