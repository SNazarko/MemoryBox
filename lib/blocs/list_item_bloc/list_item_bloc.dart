import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'list_item_event.dart';
part 'list_item_state.dart';

class ListItemBloc extends Bloc<ListItemEvent, ListItemState> {
  ListItemBloc() : super(const ListItemState()) {
    on<LoadListItemEvent>(
        (LoadListItemEvent event, Emitter<ListItemState> emit) {
      try {
        emit(state.copyWith(
          status: ListItemStatus.success,
          streamList: event.streamList?.listen((loadedAudio) {
            add(UpdateListItemEvent(list: loadedAudio));
          }),
        ));
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
