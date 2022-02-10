import 'package:flutter/cupertino.dart';

class ModelPlayerMiniPodborki extends ChangeNotifier {
  bool _done = false;

  bool get done => _done;

  void doneWidget() {
    _done = !_done;
    notifyListeners();
  }
}
