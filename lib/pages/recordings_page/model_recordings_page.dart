import 'package:flutter/cupertino.dart';

class ModelRP with ChangeNotifier {
  String? _path;
  String? _duration;

  get getDuration => _duration;

  void setDuration(String minutes, String seconds) {
    _duration = '$minutes:$seconds';
    notifyListeners();
  }

  get getData => _path!;

  void changeString(String newString) {
    _path = newString;
    notifyListeners();
  }
}
