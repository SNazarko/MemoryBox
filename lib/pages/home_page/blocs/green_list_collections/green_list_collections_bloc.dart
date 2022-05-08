import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../models/collections_model.dart';

part 'green_list_collections_event.dart';
part 'green_list_collections_state.dart';

class GreenListItemBloc extends Bloc<GreenListItemEvent, GreenListItemState> {
  GreenListItemBloc() : super(const GreenListItemState()) {
    on<LoadGreenListItemEvent>(
        (LoadGreenListItemEvent event, Emitter<GreenListItemState> emit) {
      try {
        emit(state.copyWith(
          status: GreenListItemStatus.success,
          streamList: event.streamList?.listen((loadedAudio) {
            add(UpdateGreenListItemEvent(list: loadedAudio));
          }),
        ));
      } on Exception {
        emit(state.copyWith(
          status: GreenListItemStatus.failed,
        ));
      }
    });

    on<UpdateGreenListItemEvent>(
        (UpdateGreenListItemEvent event, Emitter<GreenListItemState> emit) {
      if (event.list.isNotEmpty) {
        emit(
          state.copyWith(
            status: GreenListItemStatus.success,
            list: event.list,
          ),
        );
      } else {
        emit(state.copyWith(
          status: GreenListItemStatus.emptyList,
        ));
      }
    });
  }
}
