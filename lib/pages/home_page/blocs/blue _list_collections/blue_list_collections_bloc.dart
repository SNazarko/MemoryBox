import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../models/collections_model.dart';

part 'blue_list_collections_event.dart';
part 'blue_list_collections_state.dart';

class BlueListItemBloc extends Bloc<BlueListItemEvent, BlueListItemState> {
  BlueListItemBloc() : super(const BlueListItemState()) {
    on<LoadBlueListItemEvent>(
        (LoadBlueListItemEvent event, Emitter<BlueListItemState> emit) {
      try {
        emit(state.copyWith(
          status: BlueListItemStatus.success,
          streamList: event.streamList?.listen((loadedAudio) {
            add(UpdateBlueListItemEvent(list: loadedAudio));
          }),
        ));
      } on Exception {
        emit(state.copyWith(
          status: BlueListItemStatus.failed,
        ));
      }
    });

    on<UpdateBlueListItemEvent>(
        (UpdateBlueListItemEvent event, Emitter<BlueListItemState> emit) {
      if (event.list.isNotEmpty) {
        emit(
          state.copyWith(
            status: BlueListItemStatus.success,
            list: event.list,
          ),
        );
      } else {
        emit(state.copyWith(
          status: BlueListItemStatus.emptyList,
        ));
      }
    });
  }
}
