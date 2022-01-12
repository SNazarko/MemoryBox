import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:meta/meta.dart';

part 'bloc_all_event.dart';
part 'bloc_all_state.dart';

class PlayAllRepeatBloc extends Bloc<PlayAllRepeatEvent, Color> {
  PlayAllRepeatBloc() : super(AppColor.white100) {
    on<PlayAllEvent>((event, emit) {
      emit(AppColor.white100);
    });
    on<RepeatEvent>((event, emit) {
      emit(AppColor.violet);
    });
  }
}
