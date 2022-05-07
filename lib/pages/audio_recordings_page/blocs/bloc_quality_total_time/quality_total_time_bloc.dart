import 'package:bloc/bloc.dart';
import 'package:memory_box/pages/audio_recordings_page/blocs/bloc_quality_total_time/quality_total_time_event.dart';
import 'package:memory_box/pages/audio_recordings_page/blocs/bloc_quality_total_time/quality_total_time_state.dart';

class QualityTotalTimeBloc
    extends Bloc<QualityTotalTimeEvent, QualityTotalTimeState> {
  QualityTotalTimeBloc() : super(const QualityTotalTimeState()) {
    on<LoadQualityTotalTimeEvent>(
        (LoadQualityTotalTimeEvent event, Emitter<QualityTotalTimeState> emit) {
      try {
        emit(state.copyWith(
          status: QualityTotalTimeStatus.success,
          streamList: event.streamList?.listen((qualityTotalTime) {
            add(UpdateQualityTotalTimeEvent(
                qualityTotalTime: qualityTotalTime));
          }),
        ));
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
}
