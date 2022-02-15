import 'package:flutter/cupertino.dart';

class PodborkiAddAudioModel extends ChangeNotifier {
  String? _searchtxt;

  String get getSearchtxt => _searchtxt!;

  void setSearchtxt(String searchtxt) {
    _searchtxt = _searchtxt;
    notifyListeners();
  }
}
