import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/models/collections_model.dart';

class CollectionsRepositories {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Stream<List<CollectionsModel>> readAudio() => FirebaseFirestore.instance
      .collection('CollectionsTale')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => CollectionsModel.fromJson(doc.data()))
          .toList());

  Future<void> addCollections(
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
    FirebaseFirestore.instance.collection('CollectionsTale').doc().set(json);
  }

  Future<void> addAudioForCollection(
    String audioName,
    String audioUrl,
    String duration,
  ) async {
    final model = AudioModel(
      audioName: audioName,
      audioUrl: audioUrl,
      duration: duration,
    );
    final json = model.toJson();
    FirebaseFirestore.instance
        .collection('CollectionsTale')
        .doc()
        .collection('Audio')
        .doc()
        .set(json);
  }
}
