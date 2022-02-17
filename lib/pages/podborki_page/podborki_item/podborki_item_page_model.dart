import 'package:flutter/cupertino.dart';

class PodborkiItemPageModel extends ChangeNotifier {
  String? _title;
  String? _subTitle;
  String? _photo;
  String? _data;
  String? _quality;
  double? _anim = 0.0;

  get getData => _data;
  void setData(String data) {
    _data = data;
    notifyListeners();
  }

  void setAnim(double anim) {
    _anim = anim;
    notifyListeners();
  }

  get getAnim => _anim;

  get getQuality => _quality;

  void setQuality(String quality) {
    _quality = quality;
    notifyListeners();
  }

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
