import 'package:flutter/cupertino.dart';

class SearchPageModel extends ChangeNotifier {
  String? _searchData;
  String? _searchAddAudio;

  get getSearchData => _searchData;
  void setSearchData(String searchData) {
    _searchData = searchData;
    notifyListeners();
  }

  get getSearchAddAudio => _searchAddAudio;

  void setSearchAddAudio(String searchAddAudio) {
    _searchAddAudio = searchAddAudio;
    notifyListeners();
  }
}
