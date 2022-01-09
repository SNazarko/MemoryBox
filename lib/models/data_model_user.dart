import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:memory_box/models/preferences_data_model_user.dart';

class DataModel with ChangeNotifier {
  late String _name = 'Имя';
  late String _number = '+0(000)000 00 00';
  late File _image;

  Future<void> initPreferencesDataUser() async {
    final saveName = await PreferencesDataUser().readName();
    _name = saveName!;
  }

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
