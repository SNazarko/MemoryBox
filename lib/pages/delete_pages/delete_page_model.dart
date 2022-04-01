import 'package:flutter/cupertino.dart';

class DeletePageModel extends ChangeNotifier {
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
}
