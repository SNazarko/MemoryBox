import 'package:flutter/cupertino.dart';

class CollectionsEditModel with ChangeNotifier {
  String? _title = 'Без названия';
  String? _subTitle = '...';
  String? _image = '';

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
