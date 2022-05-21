import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteItemDoneCubit extends Cubit<bool> {
  DeleteItemDoneCubit() : super(false);

  void itemDone() {
    emit(
      state == false,
    );
  }
}
