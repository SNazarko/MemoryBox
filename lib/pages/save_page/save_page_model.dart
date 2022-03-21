import 'package:flutter/cupertino.dart';

class SavePageModel extends ChangeNotifier {
  String? _idAudio;
  String? _audioName;
  String? _audioUrl;
  String? _duration;
  bool? _done;
  String? _dateTime;
  List? _newSearchName;
  List? _searchName;
  List? _collection;
  String? _newAudioName;

  get getIdAudio => _idAudio;
  void setIdAudio(String idAudio) {
    _idAudio = idAudio;
    notifyListeners();
  }

  get getCollection => _collection;
  void setCollection(List collection) {
    _collection = collection;
    notifyListeners();
  }

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

  get getNewSearchName => _newSearchName;
  void setNewSearchName(List newSearchName) {
    _newSearchName = newSearchName;
    notifyListeners();
  }
}
