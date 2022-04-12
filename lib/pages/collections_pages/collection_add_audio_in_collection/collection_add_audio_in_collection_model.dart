import 'package:flutter/cupertino.dart';

class CollectionAddAudioInCollectionModel extends ChangeNotifier {
  List? _collectionAudio;
  String? _idAudio;
  get getCollectionAudio => _collectionAudio;

  void setCollectionAudio(List collectionAudio) {
    _collectionAudio = collectionAudio;
    notifyListeners();
  }

  get getIdAudio => _idAudio;

  void setIdAudio(String idAudio) {
    _idAudio = idAudio;
    notifyListeners();
  }
}
