import 'package:flutter/cupertino.dart';

class ModelDone extends ChangeNotifier {
  bool _done = false;

  bool get getDone => _done;

  void doneWidget() {
    if (_done) {
      _done = false;
      notifyListeners();
    } else {
      _done = true;
      notifyListeners();
    }
  }
}