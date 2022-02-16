import 'package:flutter/cupertino.dart';

class PodborkiItemPageModel extends ChangeNotifier {
  String? _title;
  String? _subTitle;
  String? _photo;

  get getTitle => _title;

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  get getSubTitle => _subTitle;

  void setSubTitle(String subTitle) {
    _subTitle = subTitle;
    notifyListeners();
  }

  get getPhoto => _photo;

  void setPhoto(String photo) {
    _photo = photo;
    notifyListeners();
  }
}
