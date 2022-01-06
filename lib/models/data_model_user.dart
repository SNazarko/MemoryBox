import 'dart:io';

import 'package:flutter/foundation.dart';

class DataModel with ChangeNotifier {
  late String _name = 'Ваше Имя';
  late String _number = '+3(063)444 22 55';
  late File _image = File('');

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
