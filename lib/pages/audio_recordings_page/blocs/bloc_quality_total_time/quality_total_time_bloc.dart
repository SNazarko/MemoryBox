import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:memory_box/pages/audio_recordings_page/blocs/bloc_quality_total_time/quality_total_time_event.dart';
import 'package:memory_box/pages/audio_recordings_page/blocs/bloc_quality_total_time/quality_total_time_state.dart';

import '../../../../repositories/user_repositories.dart';

class QualityTotalTimeBloc
    extends Bloc<QualityTotalTimeEvent, QualityTotalTimeState> {
  final UserRepositories _repositories;
  StreamSubscription? _itemsSubscriptions;
  QualityTotalTimeBloc({required UserRepositories repositories})
      : _repositories = repositories,
        super(const QualityTotalTimeState()) {
    void _onLoadQualityTotalTimeEvent(
        LoadQualityTotalTimeEvent event, Emitter<QualityTotalTimeState> emit) {
      _itemsSubscriptions?.cancel();
      _itemsSubscriptions = _repositories.readUser().listen((qualityTotalTime) {
        add(UpdateQualityTotalTimeEvent(qualityTotalTime: qualityTotalTime));
      });
    }

    void _onUpdateQualityTotalTimeEvent(UpdateQualityTotalTimeEvent event,
        Emitter<QualityTotalTimeState> emit) {
      emit(state.copyWith(
          status: QualityTotalTimeStatus.success,
          qualityTotalTime: event.qualityTotalTime));
    }

    on<LoadQualityTotalTimeEvent>(
      _onLoadQualityTotalTimeEvent,
    );
    on<UpdateQualityTotalTimeEvent>(
      _onUpdateQualityTotalTimeEvent,
    );
  }
}
