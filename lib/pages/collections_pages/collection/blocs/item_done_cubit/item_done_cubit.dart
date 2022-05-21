import 'package:flutter_bloc/flutter_bloc.dart';

class ItemDoneCubit extends Cubit<bool> {
  ItemDoneCubit() : super(false);

  void itemDone() {
    emit(
      state == false,
    );
  }
}
