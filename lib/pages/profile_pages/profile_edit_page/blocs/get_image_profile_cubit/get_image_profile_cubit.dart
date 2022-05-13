import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../repositories/user_repositories.dart';
import '../../../../../widgets/uncategorized/image_pick.dart';

part 'get_image_profile_state.dart';

class GetImageProfileCubit extends Cubit<GetImageProfileState> {
  final ImagePick _imagePick = ImagePick();
  GetImageProfileCubit() : super(const GetImageProfileState());
  Future<void> getImage() async {
    String? _singleImage;
    XFile? _image = await _imagePick.singleImagePick();
    if (_image != null && _image.path.isNotEmpty) {
      _singleImage = await UserRepositories.instance.uploadImage(_image);
      emit(
        state.copyWith(image: _singleImage),
      );
    }
  }
}