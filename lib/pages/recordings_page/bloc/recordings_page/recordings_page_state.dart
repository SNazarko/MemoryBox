part of 'recordings_page_bloc.dart';

@immutable
class RecordingsPageState extends Equatable {
  const RecordingsPageState({
    this.path,
    this.minutes,
    this.seconds,
  });
  final String? path;
  final String? minutes;
  final String? seconds;

  RecordingsPageState copyWith({
    String? path,
    String? minutes,
    String? seconds,
  }) {
    return RecordingsPageState(
      path: path ?? this.path,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        path,
        minutes,
        seconds,
      ];
}
