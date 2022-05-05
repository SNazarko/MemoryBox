import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repositories/audio_repositories.dart';
import 'audio_recordings_list_event.dart';
import 'audio_recordings_list_state.dart';

class AudioRecordingsListBloc
    extends Bloc<AudioRecordingsListEvent, AudioRecordingsListState> {
  final AudioRepositories _repositories;
  StreamSubscription? _itemsSubscriptions;
  AudioRecordingsListBloc({required AudioRepositories repositories})
      : _repositories = repositories,
        super(const AudioRecordingsListState()) {
    on<LoadAudioRecordingsListEvent>((LoadAudioRecordingsListEvent event,
        Emitter<AudioRecordingsListState> emit) {
      try {
        _itemsSubscriptions?.cancel();
        _itemsSubscriptions =
            _repositories.readAudioSort('all').listen((loadedAudio) {
          add(UpdateAudioRecordingsListEvent(loadedAudio: loadedAudio));
        });
      } on Exception catch (e) {
        emit(state.copyWith(status: AudioRecordingsListStateStatus.failed));
      }
    });

    on<UpdateAudioRecordingsListEvent>((UpdateAudioRecordingsListEvent event,
        Emitter<AudioRecordingsListState> emit) {
      emit(
        state.copyWith(
            status: AudioRecordingsListStateStatus.success,
            loadedAudio: event.loadedAudio),
      );
    });
  }
}
