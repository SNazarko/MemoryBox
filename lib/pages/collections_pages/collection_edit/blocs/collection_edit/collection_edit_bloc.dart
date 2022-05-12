import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'collection_edit_event.dart';
part 'collection_edit_state.dart';

class CollectionEditBloc
    extends Bloc<CollectionEditEvent, CollectionEditState> {
  CollectionEditBloc() : super(const CollectionEditState()) {
    on<CollectionEditEvent>((event, emit) {
      emit(state.copyWith(
        title: event.title,
        subTitle: event.subTitle,
      ));
    });
  }
}
