import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:memory_box/models/preferences_data_model_user.dart';

class DataModel with ChangeNotifier {
  late String name = 'Имя';
  late String number = '+0(000)000 00 00';
  late File image = File('');

  void userImage(File userImage) {
    image = userImage;
    notifyListeners();
  }

  File get getUserImage => image;

  void userName(String userName) {
    name = userName;
    notifyListeners();
  }

  String get getName => name;

  void userNumber(String userNumber) {
    number = userNumber;
    notifyListeners();
  }

  String get getNumber => number;
}
