import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'anim_event.dart';
part 'anim_state.dart';

class AnimBloc
    extends Bloc<AudioRecordingsAnimEvent, AudioRecordingsAnimState> {
  AnimBloc() : super(const AudioRecordingsAnimState()) {
    on<OpenAnimAudioRecordings>((event, emit) {
      emit(
        state.copyWith(
            status: AudioRecordingsAnimStatus.open, anim: event.anim),
      );
    });
  }
}
