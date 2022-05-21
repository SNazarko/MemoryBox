import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../repositories/audio_repositories.dart';

part 'search_page_event.dart';
part 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  StreamSubscription? _audioSubscription;
  SearchPageBloc()
      : super(
          const SearchPageState(),
        ) {
    on<LoadSearchPageEvent>((
      LoadSearchPageEvent event,
      Emitter<SearchPageState> emit,
    ) {
      try {
        if (event.sort == null || event.sort == '') {
          _audioSubscription?.cancel();
          _audioSubscription = AudioRepositories.instance
              .readAudio(
            'all',
            'Collections',
            'collections',
          )
              .listen((audioList) {
            add(
              UpdateSearchPageEvent(
                list: audioList,
              ),
            );
          });
        } else {
          _audioSubscription?.cancel();
          _audioSubscription = AudioRepositories.instance
              .readAudio(
            event.sort!,
            'Collections',
            'searchName',
          )
              .listen((audioList) {
            add(
              UpdateSearchPageEvent(
                list: audioList,
              ),
            );
          });
        }
      } on Exception {
        emit(
          state.copyWith(
            status: SearchPageStatus.failed,
          ),
        );
      }
    });

    on<UpdateSearchPageEvent>((
      UpdateSearchPageEvent event,
      Emitter<SearchPageState> emit,
    ) {
      emit(
        state.copyWith(
          status: SearchPageStatus.success,
          list: event.list,
        ),
      );
    });
  }
  @override
  Future<void> close() {
    _audioSubscription?.cancel();
    return super.close();
  }
}
