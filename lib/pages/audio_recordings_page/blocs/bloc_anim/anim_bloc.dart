import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'anim_event.dart';
part 'anim_state.dart';

class AnimBloc extends Bloc<AnimEvent, AnimState> {
  AnimBloc()
      : super(
          const AnimState(),
        ) {
    on<AnimEvent>((
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
