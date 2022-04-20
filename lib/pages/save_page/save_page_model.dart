import 'package:flutter/cupertino.dart';

class SavePageModel extends ChangeNotifier {
  List? _newSearchName;
  String? _newAudioName;

  get getNewAudioName => _newAudioName;
  void setNewAudioName(String newAudioName) {
    _newAudioName = newAudioName;
    notifyListeners();
  }

  get getNewSearchName => _newSearchName;
  void setNewSearchName(List newSearchName) {
    _newSearchName = newSearchName;
    notifyListeners();
  }
}
