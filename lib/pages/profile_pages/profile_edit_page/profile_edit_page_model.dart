import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repositories/user_repositories.dart';
import '../../../widgets/uncategorized/image_pick.dart';
import '../profile_model.dart';

class ProfileEditPageModel extends ChangeNotifier {
  String? _name;
  String? _number;
  String? _singleImage;

  get getName => _name;
  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  get getNumber => _number;
  void setNumber(String number) {
    _number = number;
    notifyListeners();
  }

  get getSingleImage => _singleImage;

  Future<void> onTapPhoto(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    XFile? _image = await ImagePick().singleImagePick();
    if (_image != null && _image.path.isNotEmpty) {
      _singleImage = await UserRepositories().uploadImage(_image);
      context.read<DataModel>().userImage(_singleImage!);
      await prefs.setString(
          'image', await UserRepositories().uploadImage(_image));
      notifyListeners();
    }
  }
}
