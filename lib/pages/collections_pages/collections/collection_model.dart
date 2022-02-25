import 'package:flutter/cupertino.dart';

class CollectionModel extends ChangeNotifier {
  bool _done = false;

  get getStateDone => _done;

  void stateDone() {
    if (_done) {
      _done = false;
      notifyListeners();
    } else {
      _done = true;
      notifyListeners();
    }
  }
}
