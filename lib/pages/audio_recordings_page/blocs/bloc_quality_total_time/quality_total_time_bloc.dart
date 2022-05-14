import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:memory_box/pages/audio_recordings_page/blocs/bloc_quality_total_time/quality_total_time_event.dart';
import 'package:memory_box/pages/audio_recordings_page/blocs/bloc_quality_total_time/quality_total_time_state.dart';

import '../../../../repositories/user_repositories.dart';

class QualityTotalTimeBloc
    extends Bloc<QualityTotalTimeEvent, QualityTotalTimeState> {
  StreamSubscription? _qualityTotalTimeSubscription;
  QualityTotalTimeBloc() : super(const QualityTotalTimeState()) {
    on<LoadQualityTotalTimeEvent>(
        (LoadQualityTotalTimeEvent event, Emitter<QualityTotalTimeState> emit) {
      try {
        _qualityTotalTimeSubscription?.cancel();
        _qualityTotalTimeSubscription =
            UserRepositories.instance.readUser().listen((qualityTotalTime) {
          add(UpdateQualityTotalTimeEvent(qualityTotalTime: qualityTotalTime));
        });
      } on Exception {
        emit(state.copyWith(
          status: QualityTotalTimeStatus.failed,
        ));
      }
    });

    on<UpdateQualityTotalTimeEvent>((UpdateQualityTotalTimeEvent event,
        Emitter<QualityTotalTimeState> emit) {
      emit(
        state.copyWith(
            status: QualityTotalTimeStatus.success,
            qualityTotalTime: event.qualityTotalTime),
      );
    });
  }
  @override
  Future<void> close() {
    _qualityTotalTimeSubscription?.cancel();
    return super.close();
  }
}
