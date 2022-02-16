import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/models/collections_model.dart';

class CollectionsRepositories {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  // int _counter = 0;
  // List<int> _counterQuality = [];
  //
  // void counterAdd(int counter) {
  //   _counter = counter++;
  //
  //   print(_counter);
  // }

  // int counterDelete(int counter) {
  //   _counter = counter + 1;
  //   try {
  //     _counterQuality.remove(_counterQuality.last);
  //   } on Exception catch (e) {
  //     print(e);
  //   }
  //   _counter = _counterQuality.length;
  //   print(_counter);
  //   print(_counterQuality);
  //   return _counter;
  // }

  Stream<List<CollectionsModel>> readAudio() => FirebaseFirestore.instance
      .collection('CollectionsTale')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => CollectionsModel.fromJson(doc.data()))
          .toList());

  Future<void> addCollections(
    String nameCollection,
    String titleCollections,
    String subTitleCollections,
    String avatarCollections,
  ) async {
    final model = CollectionsModel(
      titleCollections: titleCollections,
      subTitleCollections: subTitleCollections,
      avatarCollections: avatarCollections,
    );
    final json = model.toJson();
    FirebaseFirestore.instance
        .collection('CollectionsTale')
        .doc(nameCollection)
        .set(json);
  }

  Future<void> addAudioForCollection(
    String nameCollection,
    String audioName,
    String audioUrl,
    String duration,
    bool done,
  ) async {
    final model = AudioModel(
      audioName: audioName,
      audioUrl: audioUrl,
      duration: duration,
      done: done,
    );
    final json = model.toJson();
    FirebaseFirestore.instance
        .collection('CollectionsTale')
        .doc(
          nameCollection,
        )
        .collection('Audio')
        .doc(audioName)
        .set(json);
  }

  Future<void> deleteAudioForCollection(
    String nameCollection,
    String audioName,
  ) async {
    FirebaseFirestore.instance
        .collection('CollectionsTale')
        .doc(
          nameCollection,
        )
        .collection('Audio')
        .doc(audioName)
        .delete();
  }
}
