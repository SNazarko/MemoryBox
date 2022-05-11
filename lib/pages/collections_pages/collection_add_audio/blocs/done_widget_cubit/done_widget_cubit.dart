import 'package:flutter_bloc/flutter_bloc.dart';

class DoneWidgetCubit extends Cubit<bool> {
  DoneWidgetCubit() : super(false);

  void itemDone() {
    emit(state == false);
  }
}
