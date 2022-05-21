import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../repositories/user_repositories.dart';

part 'subscription_page_event.dart';
part 'subscription_page_state.dart';

class SubscriptionPageBloc
    extends Bloc<SubscriptionPageEvent, SubscriptionPageState> {
  StreamSubscription? _subscription;
  SubscriptionPageBloc()
      : super(
          const SubscriptionPageState(),
        ) {
    on<LoadSubscriptionPageEvent>((
      LoadSubscriptionPageEvent event,
      Emitter<SubscriptionPageState> emit,
    ) {
      try {
        _subscription?.cancel();
        _subscription = UserRepositories.instance.readUser().listen((list) {
          add(
            UpdateSubscriptionPageEvent(
              subscription: list,
            ),
          );
        });
      } on Exception {
        emit(
          state.copyWith(
            status: SubscriptionPageStatus.failed,
          ),
        );
      }
    });

    on<UpdateSubscriptionPageEvent>((
      UpdateSubscriptionPageEvent event,
      Emitter<SubscriptionPageState> emit,
    ) {
      emit(
        state.copyWith(
            status: SubscriptionPageStatus.success,
            subscription: event.subscription),
      );
    });
  }
  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
