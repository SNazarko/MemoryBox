import 'package:flutter/cupertino.dart';

class SavePageModel extends ChangeNotifier {
  String? _audioName;
  String? _audioUrl;
  String? _duration;
  bool? _done;
  String? _dateTime;
  List? _searchName;
  String? _newAudioName;

  get getNewAudioName => _newAudioName;
  void setNewAudioName(String newAudioName) {
    _newAudioName = newAudioName;
    notifyListeners();
  }

  get getAudioName => _audioName;
  void setAudioName(String audioName) {
    _audioName = audioName;
    notifyListeners();
  }

  get getAudioUrl => _audioUrl;
  void setAudioUrl(String audioUrl) {
    _audioUrl = audioUrl;
    notifyListeners();
  }

  get getDuration => _duration;
  void setDuration(String duration) {
    _duration = duration;
    notifyListeners();
  }

  get getDone => _done;
  void setDone(bool done) {
    _done = done;
    notifyListeners();
  }

  get getDateTime => _dateTime;
  void setDateTime(String dateTime) {
    _dateTime = dateTime;
    notifyListeners();
  }

  get getSearchName => _searchName;
  void setSearchName(List searchName) {
    _searchName = searchName;
    notifyListeners();
  }
}
