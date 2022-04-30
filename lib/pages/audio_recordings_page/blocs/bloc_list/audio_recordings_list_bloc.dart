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
    void _onLoadAudioRecordingsListEvent(LoadAudioRecordingsListEvent event,
        Emitter<AudioRecordingsListState> emit) {
      _itemsSubscriptions?.cancel();
      _itemsSubscriptions =
          _repositories.readAudioSort('all').listen((loadedAudio) {
        add(UpdateAudioRecordingsListEvent(loadedAudio: loadedAudio));
      });
    }

    void _onUpdateAudioRecordingsListEvent(UpdateAudioRecordingsListEvent event,
        Emitter<AudioRecordingsListState> emit) {
      emit(
        state.copyWith(
            status: AudioRecordingsListStateStatus.loaded,
            loadedAudio: event.loadedAudio),
      );
    }

    void _onSelectAudioRecordingsListEvent(SelectAudioRecordingsListEvent event,
        Emitter<AudioRecordingsListState> emit) {
      emit(
        state.copyWith(
            status: AudioRecordingsListStateStatus.selected,
            loadedAudio: event.loadedAudio),
      );
    }

    on<LoadAudioRecordingsListEvent>(
      _onLoadAudioRecordingsListEvent,
    );

    on<UpdateAudioRecordingsListEvent>(
      _onUpdateAudioRecordingsListEvent,
    );

    on<SelectAudioRecordingsListEvent>(
      _onSelectAudioRecordingsListEvent,
    );
  }
}
