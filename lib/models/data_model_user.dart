import 'dart:io';

import 'package:flutter/foundation.dart';

class DataModel with ChangeNotifier {
  late String _name = 'Ваше Имя';
  late String _number = '+0(000)000 00 00';
  late File _image;

  void userImage(File userImage) {
    _image = userImage;
    notifyListeners();
  }

  File get getUserImage => _image;

  void userName(String userName) {
    _name = userName;
    notifyListeners();
  }

  String get getName => _name;
  void userNumber(String userNumber) {
    _number = userNumber;
    notifyListeners();
  }

  String get getNumber => _number;
}
