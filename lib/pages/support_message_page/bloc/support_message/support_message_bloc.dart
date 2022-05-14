import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../repositories/user_repositories.dart';

part 'support_message_event.dart';
part 'support_message_state.dart';

class SupportMessageBloc
    extends Bloc<SupportMessageEvent, SupportMessageState> {
  StreamSubscription? _messageSubscription;
  SupportMessageBloc() : super(const SupportMessageState()) {
    on<LoadSupportMessageEvent>(
        (LoadSupportMessageEvent event, Emitter<SupportMessageState> emit) {
      try {
        _messageSubscription?.cancel();
        _messageSubscription =
            UserRepositories.instance.readUserShat().listen((shatList) {
          add(UpdateSupportMessageEvent(list: shatList));
        });
      } on Exception {
        emit(state.copyWith(
          status: SupportMessageStatus.failed,
        ));
      }
    });

    on<UpdateSupportMessageEvent>(
        (UpdateSupportMessageEvent event, Emitter<SupportMessageState> emit) {
      emit(
        state.copyWith(
          status: SupportMessageStatus.success,
          list: event.list,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
