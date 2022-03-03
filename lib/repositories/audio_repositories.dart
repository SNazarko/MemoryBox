import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/models/user_model.dart';

class AudioRepositories {
  UserModel userModel = UserModel();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Stream<List<AudioModel>> readAudio() => FirebaseFirestore.instance
      .collection('Collections')
      .orderBy('dateTime')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AudioModel.fromJson(doc.data())).toList());

  Stream<List<AudioModel>> readAudioPodbirka(String name) => FirebaseFirestore
      .instance
      .collection('CollectionsTale')
      .doc(name)
      .collection('Audio')
      .orderBy('dateTime')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AudioModel.fromJson(doc.data())).toList());

  Future<void> uploadAudio(String path, String name, String duration) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('userAudio/${getAudioName(path)}');
    await ref.putFile(File(path));
    final _todayDate = DateTime.now();
    final model = AudioModel(
      audioName: name,
      audioUrl: await ref.getDownloadURL(),
      duration: duration,
      dateTime: formatDate(
          _todayDate, [dd, '.', mm, '.', yy, HH, ':', nn, ':', ss, z]),
    );
    final json = model.toJson();
    FirebaseFirestore.instance.collection('Collections').doc(name).set(json);
  }

  String getAudioName(String name) {
    return name.split('/').last;
  }

  Future<void> renameAudio(
    String lastName,
    String newNameAudio,
    String newAudioUrl,
    String duration,
  ) async {
    final model = AudioModel(
      audioName: newNameAudio,
      audioUrl: newAudioUrl,
      duration: duration,
    );
    final json = model.toJson();
    FirebaseFirestore.instance.collection('Collections').doc(lastName).delete();
    FirebaseFirestore.instance
        .collection('CollectionsTale')
        .doc()
        .collection('Audio')
        .doc(lastName)
        .delete();
    FirebaseFirestore.instance
        .collection('DeleteCollections')
        .doc()
        .collection('Audio')
        .doc(lastName)
        .delete();
    FirebaseFirestore.instance
        .collection('Collections')
        .doc(newNameAudio)
        .set(json);
    FirebaseFirestore.instance
        .collection('CollectionsTale')
        .doc()
        .collection('Audio')
        .doc(newNameAudio)
        .set(json);
    FirebaseFirestore.instance
        .collection('DeleteCollections')
        .doc()
        .collection('Audio')
        .doc(newNameAudio)
        .set(json);
  }
}
