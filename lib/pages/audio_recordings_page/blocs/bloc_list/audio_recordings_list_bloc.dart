import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/audio_model.dart';
import '../../../../repositories/audio_repositories.dart';
import 'audio_recordings_list_event.dart';
import 'audio_recordings_list_state.dart';

class AudioRecordingsListBloc
    extends Bloc<AudioRecordingsListEvent, AudioRecordingsListState> {
  AudioRepositories repositories = AudioRepositories();
  AudioRecordingsListBloc(this.repositories)
      : super(const AudioRecordingsListState()) {
    on<AudioRecordingsListEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: AudioRecordingsListStateStatus.initial,
        ),
      );
      try {
        final Stream<List<AudioModel>> _loadedUserList =
            repositories.readAudioSort('all');
        emit(state.copyWith(
            status: AudioRecordingsListStateStatus.success,
            loadedAudio: _loadedUserList));
      } on Exception catch (e) {
        emit(state.copyWith(status: AudioRecordingsListStateStatus.failed));
      }
    });
  }
}
