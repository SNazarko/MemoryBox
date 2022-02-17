import 'package:flutter/cupertino.dart';

class PodborkiAddAudioModel extends ChangeNotifier {
  String? _searchtxt;
  bool? _done;

  get getDone => _done;
  void setDone(bool done) {
    _done = done;
    notifyListeners();
  }

  String get getSearchtxt => _searchtxt!;

  void setSearchtxt(String searchtxt) {
    _searchtxt = _searchtxt;
    notifyListeners();
  }
}
