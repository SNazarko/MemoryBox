part of 'recordings_page_bloc.dart';

class RecordingsPageEvent extends Equatable {
  const RecordingsPageEvent({
    this.path,
    this.minutes,
    this.seconds,
  });
  final String? path;
  final String? minutes;
  final String? seconds;

  @override
  // TODO: implement props
  List<Object?> get props => [
        path,
        minutes,
        seconds,
      ];
}
