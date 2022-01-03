import 'package:flutter/foundation.dart';

class DataModel with ChangeNotifier {
  late String _name = '';
  late String _number = '';
  void userName(String userName) {
    _name = userName;
    notifyListeners();
  }

  String get getName => _name;
  void userNumber(String userNumber) {
    _number = userNumber;
    notifyListeners();
  }

  String get getNumber => _number;
}
