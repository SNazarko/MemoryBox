import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:memory_box/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class DataModel with ChangeNotifier {
  String? _name;
  String? _number;
  String? _image = 'assets/images/profile_avatar.png';

  DataModel() {
    init();
  }
  Future<void> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _name = sharedPreferences.getString('name_key') ?? 'Имя';
    _number = sharedPreferences.getString('number_key') ?? '+0(000)000 00 00';
    _image = sharedPreferences.getString('image') ??
        'assets/images/profile_avatar.png';
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

  void userImage(String userImage) {
    _image = userImage;
    notifyListeners();
  }

  String? get getUserImage => _image;
}
