import 'package:flutter/cupertino.dart';

class CollectionsAddAudioModel extends ChangeNotifier {
  String? _searchtxt;
  String? _searchAddAudio;
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

  get getSearchAddAudio => _searchAddAudio;

  void setSearchAddAudio(String searchAddAudio) {
    _searchAddAudio = searchAddAudio;
    notifyListeners();
  }
}
