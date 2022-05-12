import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../repositories/collections_repositories.dart';

part 'list_collection_add_audio_in_collection_event.dart';
part 'list_collection_add_audio_in_collection_state.dart';

class ListCollectionAddAudioInCollectionBloc extends Bloc<
    ListCollectionAddAudioInCollectionEvent,
    ListCollectionAddAudioInCollectionState> {
  StreamSubscription? _audioSubscription;
  ListCollectionAddAudioInCollectionBloc()
      : super(const ListCollectionAddAudioInCollectionState()) {
    on<LoadListCollectionAddAudioInCollectionEvent>(
        (LoadListCollectionAddAudioInCollectionEvent event,
            Emitter<ListCollectionAddAudioInCollectionState> emit) {
      try {
        _audioSubscription?.cancel();
        _audioSubscription = CollectionsRepositories.instance
            .readCollections()
            .listen((audioList) {
          add(UpdateListCollectionAddAudioInCollectionEvent(list: audioList));
        });
      } on Exception {
        emit(state.copyWith(
          status: ListCollectionAddAudioInCollectionStatus.failed,
        ));
      }
    });

    on<UpdateListCollectionAddAudioInCollectionEvent>(
        (UpdateListCollectionAddAudioInCollectionEvent event,
            Emitter<ListCollectionAddAudioInCollectionState> emit) {
      if (event.list.isNotEmpty) {
        emit(
          state.copyWith(
            status: ListCollectionAddAudioInCollectionStatus.success,
            list: event.list,
          ),
        );
      } else {
        emit(state.copyWith(
          status: ListCollectionAddAudioInCollectionStatus.emptyList,
        ));
      }
    });
  }
}
