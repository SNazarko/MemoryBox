import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class DataModel with ChangeNotifier {
  late String _name = '';
  late String _number = '';
  late File _image;

  Future<void> imagePicker() async {
    final _imageTemp =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _image = _imageTemp as File;
  }

  Future<void> userImage(imageTemp) async {
    _image = imageTemp as File;
    imagePicker();
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
