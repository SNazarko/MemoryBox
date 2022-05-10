import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repositories/audio_repositories.dart';

part 'list_item_event.dart';
part 'list_item_state.dart';

class ListItemBloc extends Bloc<ListItemEvent, ListItemState> {
  StreamSubscription? _audioSubscription;
  ListItemBloc() : super(const ListItemState()) {
    on<LoadListItemEvent>(
        (LoadListItemEvent event, Emitter<ListItemState> emit) {
      try {
        _audioSubscription?.cancel();
        _audioSubscription = AudioRepositories.instance
            .readAudio(event.sort!, event.collection!)
            .listen((audioList) {
          add(UpdateListItemEvent(list: audioList));
        });
      } on Exception {
        emit(state.copyWith(
          status: ListItemStatus.failed,
        ));
      }
    });

    on<UpdateListItemEvent>(
        (UpdateListItemEvent event, Emitter<ListItemState> emit) {
      if (event.list.isNotEmpty) {
        emit(
          state.copyWith(
            status: ListItemStatus.success,
            list: event.list,
          ),
        );
      } else {
        emit(state.copyWith(
          status: ListItemStatus.emptyList,
        ));
      }
    });
  }
}
