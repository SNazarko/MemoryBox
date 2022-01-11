import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataModel with ChangeNotifier {
  String? _name;
  String? _number;
  late File _image = File('memory_box/assets/images/avatarka.jpg');

  DataModel() {
    init();
  }
  Future<void> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _name = sharedPreferences.getString('name_key') ?? 'Имя';
    _number = sharedPreferences.getString('number_key') ?? '+0(000)000 00 00';
    notifyListeners();
  }

  void userName(String userName) {
    _name = userName;
    notifyListeners();
  }

  String? get getName => _name;

  void userNumber(String userNumber) {
    _number = userNumber;
    notifyListeners();
  }

  String? get getNumber => _number;

  void userImage(File userImage) {
    _image = userImage;
    notifyListeners();
  }

  File get getUserImage => _image;
}
