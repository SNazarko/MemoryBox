import 'package:flutter/cupertino.dart';

class CollectionModel extends ChangeNotifier {
  bool _done = true;
  bool _itemDone = false;

  get getItemDone => _itemDone;

  void stateCollections() {
    if (_itemDone) {
      _itemDone = false;
      notifyListeners();
    } else {
      _itemDone = true;
      notifyListeners();
    }
  }

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
