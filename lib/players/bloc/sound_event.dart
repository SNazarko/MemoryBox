part of 'sound_bloc.dart';

abstract class PlayStopEvent {}

class RecordPlay extends PlayStopEvent {}

class RecordStop extends PlayStopEvent {}

class PlayerPlay extends PlayStopEvent {}

class PlayerStop extends PlayStopEvent {}
