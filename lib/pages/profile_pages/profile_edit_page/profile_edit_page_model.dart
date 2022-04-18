import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repositories/user_repositories.dart';
import '../../../widgets/uncategorized/image_pick.dart';
import '../profile_model.dart';

class ProfileEditPageModel extends ChangeNotifier {
  String? singleImage;

  get getSingleImage => singleImage;

  Future<void> onTapPhoto(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    XFile? _image = await ImagePick().singleImagePick();
    if (_image != null && _image.path.isNotEmpty) {
      singleImage = await UserRepositories().uploadImage(_image);
      context.read<DataModel>().userImage(singleImage!);
      await prefs.setString(
          'image', await UserRepositories().uploadImage(_image));
      notifyListeners();
    }
  }
}
