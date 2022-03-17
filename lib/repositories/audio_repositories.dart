import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/models/user_model.dart';

class AudioRepositories {
  AudioRepositories() {
    init();
  }
  UserModel userModel = UserModel();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseAuth? auth;
  User? user;

  void init() {
    auth = FirebaseAuth.instance;
    user = auth!.currentUser;
  }

  Stream<List<AudioModel>> readAudio() => FirebaseFirestore.instance
      .collection(user!.phoneNumber!)
      .doc('id')
      .collection('Collections')
      .orderBy('dateTime')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AudioModel.fromJson(doc.data())).toList());

  Stream<List<AudioModel>> readAudioPodbirka(String name) => FirebaseFirestore
      .instance
      .collection(user!.phoneNumber!)
      .doc('id')
      .collection('CollectionsTale')
      .doc(name)
      .collection('Audio')
      .where('done', isEqualTo: true)
      // .orderBy('dateTime')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AudioModel.fromJson(doc.data())).toList());
  Stream<List<AudioModel>> readAudioCollectionEdit(String name) =>
      FirebaseFirestore.instance
          .collection(user!.phoneNumber!)
          .doc('id')
          .collection('CollectionsTale')
          .doc(name)
          .collection('Audio')
          // .where('done', isEqualTo: true)
          // .orderBy('dateTime')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => AudioModel.fromJson(doc.data()))
              .toList());

  Future<void> uploadAudio(
    String path,
    String name,
    String duration,
    Set searchName,
  ) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('${user!.phoneNumber!}/userAudio/${getAudioName(path)}');
    await ref.putFile(File(path));
    final _todayDate = DateTime.now();
    final model = AudioModel(
      audioName: name,
      audioUrl: await ref.getDownloadURL(),
      duration: duration,
      dateTime: formatDate(
          _todayDate, [dd, '.', mm, '.', yy, HH, ':', nn, ':', ss, z]),
      done: false,
      searchName: searchName.toList(),
    );
    final json = model.toJson();
    FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection('Collections')
        .doc(name)
        .set(json);
  }

  String getAudioName(String name) {
    return name.split('/').last;
  }

  Future<void> renameAudio(
    String lastName,
    String newNameAudio,
    String newAudioUrl,
    String newDuration,
    String newDateTime,
    List newSearchName,
    bool newDone,
  ) async {
    final model = AudioModel(
        audioName: newNameAudio,
        audioUrl: newAudioUrl,
        searchName: newSearchName,
        duration: newDuration,
        done: newDone,
        dateTime: newDateTime);
    final json = model.toJson();

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
  }
}
