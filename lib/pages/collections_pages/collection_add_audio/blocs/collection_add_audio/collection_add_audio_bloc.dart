import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../repositories/audio_repositories.dart';

part 'collection_add_audio_event.dart';
part 'collection_add_audio_state.dart';

class CollectionAddAudioBloc
    extends Bloc<CollectionAddAudioEvent, CollectionAddAudioState> {
  CollectionAddAudioBloc() : super(const CollectionAddAudioState()) {
    StreamSubscription? _audioSubscription;
    on<LoadCollectionAddAudioEvent>((LoadCollectionAddAudioEvent event,
        Emitter<CollectionAddAudioState> emit) {
      try {
        if (event.sort == null || event.sort == '') {
          _audioSubscription?.cancel();
          _audioSubscription = AudioRepositories.instance
              .readAudio(
            'all',
            'Collections',
            'collections',
          )
              .listen((audioList) {
            add(
              UpdateCollectionAddAudioEvent(
                list: audioList,
              ),
            );
          });
        } else {
          _audioSubscription?.cancel();
          _audioSubscription = AudioRepositories.instance
              .readAudio(
            event.sort!,
            'Collections',
            'searchName',
          )
              .listen((audioList) {
            add(
              UpdateCollectionAddAudioEvent(
                list: audioList,
              ),
            );
          });
        }
      } on Exception {
        emit(state.copyWith(
          status: CollectionAddAudioStatus.failed,
        ));
      }
    });

    on<UpdateCollectionAddAudioEvent>((UpdateCollectionAddAudioEvent event,
        Emitter<CollectionAddAudioState> emit) {
      emit(
        state.copyWith(
          status: CollectionAddAudioStatus.success,
          list: event.list,
        ),
      );
    });
    @override
    Future<void> close() {
      _audioSubscription?.cancel();
      return super.close();
    }
  }
}
