import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../repositories/user_repositories.dart';
import '../../../widgets/uncategorized/image_pick.dart';

class CollectionItemEditPageModel extends ChangeNotifier {
  final ImagePick _imagePick = ImagePick();
  String? _titleCollectionsEdit;
  String? _subTitleCollectionsEdit;
  String? _avatarCollectionsEdit;
  String? _singleImage;

  get getSingleImage => _singleImage;

  Future<void> imagePickPhoto(BuildContext context) async {
    XFile? _image = await _imagePick.singleImagePick();
    if (_image != null && _image.path.isNotEmpty) {
      _singleImage = await UserRepositories.instance.uploadImage(_image);
      context
          .read<CollectionItemEditPageModel>()
          .setAvatarCollectionsEdit(_singleImage!);
      notifyListeners();
    }
  }

  void setTitleCollectionsEdit(String titleCollectionsEdit) {
    _titleCollectionsEdit = titleCollectionsEdit;
    notifyListeners();
  }

  get getTitleCollectionsEdit => _titleCollectionsEdit;

  void setSubTitleCollectionsEdit(String subTitleCollectionsEdit) {
    _subTitleCollectionsEdit = subTitleCollectionsEdit;
    notifyListeners();
  }

  get getSubTitleCollectionsEdit => _subTitleCollectionsEdit;

  void setAvatarCollectionsEdit(String avatarCollectionsEdit) {
    _avatarCollectionsEdit = avatarCollectionsEdit;
    notifyListeners();
  }

  get getAvatarCollectionsEdit => _avatarCollectionsEdit;
}
