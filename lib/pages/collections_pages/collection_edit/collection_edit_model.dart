import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../repositories/user_repositories.dart';
import '../../../widgets/uncategorized/image_pick.dart';

class CollectionsEditModel with ChangeNotifier {
  final ImagePick _imagePick = ImagePick();
  String? _title = 'Без названия';
  String? _subTitle = '...';
  String? _image = '';
  String? _id;
  String? _singleImage;

  get getSingleImage => _singleImage;

  Future<void> imagePickPhoto(BuildContext context) async {
    XFile? _image = await _imagePick.singleImagePick();
    if (_image != null && _image.path.isNotEmpty) {
      _singleImage = await UserRepositories().uploadImage(_image);
      context.read<CollectionsEditModel>().image(_singleImage ?? '');
      notifyListeners();
    }
  }

  void setId(String idCollection) {
    _id = idCollection;
    notifyListeners();
  }

  get getId => _id;

  void userTitle(String title) {
    _title = title;
    notifyListeners();
  }

  get getTitle => _title;

  void userSubTitle(String subTitle) {
    _subTitle = subTitle;
    notifyListeners();
  }

  get getSubTitle => _subTitle;

  void image(String image) {
    _image = image;
    notifyListeners();
  }

  get getImage => _image;
}
