import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'collection_item_anim_event.dart';
part 'collection_item_anim_state.dart';

class CollectionItemAnimBloc
    extends Bloc<CollectionItemAnimEvent, CollectionItemAnimState> {
  CollectionItemAnimBloc()
      : super(
          const CollectionItemAnimState(),
        ) {
    on<CollectionItemAnimEvent>((
      event,
      emit,
    ) {
      emit(
        state.copyWith(
          anim: event.anim,
        ),
      );
    });
  }
}
