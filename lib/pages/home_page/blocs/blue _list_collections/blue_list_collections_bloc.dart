import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../models/collections_model.dart';
import '../../../../repositories/collections_repositories.dart';

part 'blue_list_collections_event.dart';
part 'blue_list_collections_state.dart';

class BlueListItemBloc extends Bloc<BlueListItemEvent, BlueListItemState> {
  StreamSubscription? _collectionSubscription;
  BlueListItemBloc() : super(const BlueListItemState()) {
    on<LoadBlueListItemEvent>(
        (LoadBlueListItemEvent event, Emitter<BlueListItemState> emit) {
      try {
        _collectionSubscription?.cancel();
        _collectionSubscription = CollectionsRepositories.instance
            .readCollections()
            .listen((collection) {
          add(UpdateBlueListItemEvent(list: collection));
        });
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
  @override
  Future<void> close() {
    _collectionSubscription?.cancel();
    return super.close();
  }
}
