import 'package:flutter/cupertino.dart';

class CollectionItemEditPageModel extends ChangeNotifier {
  String? _titleCollectionsEdit;
  String? _subTitleCollectionsEdit;
  String? _avatarCollectionsEdit;



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
