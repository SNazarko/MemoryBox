import 'package:flutter/cupertino.dart';

class CollectionsItemPageModel extends ChangeNotifier {
  double? _anim = 0.0;

  void setAnim(double anim) {
    _anim = anim;
    notifyListeners();
  }

  get getAnim => _anim;
}
