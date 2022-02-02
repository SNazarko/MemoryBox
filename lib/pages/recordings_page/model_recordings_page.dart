import 'package:flutter/cupertino.dart';

class ModelRP with ChangeNotifier {
  String? _path;

  String get getData => _path! ;

  void changeString(String newString) {
    _path  = newString;
    notifyListeners();
  }
}
