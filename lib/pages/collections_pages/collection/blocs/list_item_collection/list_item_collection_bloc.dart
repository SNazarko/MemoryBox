import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:memory_box/repositories/collections_repositories.dart';

part 'list_item_collection_event.dart';
part 'list_item_collection_state.dart';

class ListItemCollectionBloc
    extends Bloc<ListItemCollectionEvent, ListItemCollectionState> {
  StreamSubscription? _audioSubscription;
  ListItemCollectionBloc() : super(const ListItemCollectionState()) {
    on<LoadListItemCollectionEvent>((LoadListItemCollectionEvent event,
        Emitter<ListItemCollectionState> emit) {
      try {
        print('11111111111112');
        _audioSubscription?.cancel();
        _audioSubscription = CollectionsRepositories.instance
            .readCollections()
            .listen((audioList) {
          print(audioList);
          add(UpdateListItemCollectionEvent(list: audioList));
        });
      } on Exception {
        emit(state.copyWith(
          status: ListItemCollectionStatus.failed,
        ));
      }
    });

    on<UpdateListItemCollectionEvent>((UpdateListItemCollectionEvent event,
        Emitter<ListItemCollectionState> emit) {
      if (event.list.isNotEmpty) {
        emit(
          state.copyWith(
            status: ListItemCollectionStatus.success,
            list: event.list,
          ),
        );
      } else {
        emit(state.copyWith(
          status: ListItemCollectionStatus.emptyList,
        ));
      }
    });
  }
}
