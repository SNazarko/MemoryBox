part of 'bloc_all_bloc.dart';

@immutable
abstract class PlayAllRepeatEvent {}

class PlayAllEvent extends PlayAllRepeatEvent {}

class RepeatEvent extends PlayAllRepeatEvent {}
