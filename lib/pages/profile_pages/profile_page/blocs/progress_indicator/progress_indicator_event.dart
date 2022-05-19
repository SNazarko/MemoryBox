part of 'progress_indicator_bloc.dart';

@immutable
abstract class ProgressIndicatorEvent extends Equatable {
  const ProgressIndicatorEvent();
}

class LoadProgressIndicatorEvent extends ProgressIndicatorEvent {
  const LoadProgressIndicatorEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateProgressIndicatorEvent extends ProgressIndicatorEvent {
  const UpdateProgressIndicatorEvent({
    this.progressIndicator = const [],
  });
  final List progressIndicator;

  @override
  // TODO: implement props
  List<Object?> get props => [progressIndicator];
}
