import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../models/collections_model.dart';

part 'orange_list_collections_event.dart';
part 'orange_list_collections_state.dart';

class OrangeListItemBloc
    extends Bloc<OrangeListItemEvent, OrangeListItemState> {
  OrangeListItemBloc() : super(const OrangeListItemState()) {
    on<LoadOrangeListItemEvent>(
        (LoadOrangeListItemEvent event, Emitter<OrangeListItemState> emit) {
      try {
        emit(state.copyWith(
          status: OrangeListItemStatus.success,
          streamList: event.streamList?.listen((loadedAudio) {
            add(UpdateOrangeListItemEvent(list: loadedAudio));
          }),
        ));
      } on Exception {
        emit(state.copyWith(
          status: OrangeListItemStatus.failed,
        ));
      }
    });

    on<UpdateOrangeListItemEvent>(
        (UpdateOrangeListItemEvent event, Emitter<OrangeListItemState> emit) {
      if (event.list.isNotEmpty) {
        emit(
          state.copyWith(
            status: OrangeListItemStatus.success,
            list: event.list,
          ),
        );
      } else {
        emit(state.copyWith(
          status: OrangeListItemStatus.emptyList,
        ));
      }
    });
  }
}
