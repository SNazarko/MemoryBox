import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/models/user_model.dart';
import 'package:uuid/uuid.dart';

class AudioRepositories {
  AudioRepositories() {
    init();
  }
  UserModel userModel = UserModel();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseAuth? auth;
  User? user;
  var uuid = const Uuid();

  void init() {
    auth = FirebaseAuth.instance;
    user = auth!.currentUser;
  }

  Stream<List<AudioModel>> readAudioSort(String sort) => FirebaseFirestore
      .instance
      .collection(user!.phoneNumber!)
      .doc('id')
      .collection('Collections')
      .where('collections', arrayContains: sort)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AudioModel.fromJson(doc.data())).toList());

  Future<void> uploadAudio(
    String path,
    String name,
    String duration,
    Set searchName,
  ) async {
    var id = uuid.v1();
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('${user!.phoneNumber!}/userAudio/${getAudioName(path)}');
    await ref.putFile(File(path));
    final _todayDate = DateTime.now();
    final model = AudioModel(
      collections: ['all'],
      id: id,
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
        .doc(id)
        .set(json);
  }

  String getAudioName(String name) {
    return name.split('/').last;
  }

  Future<void> renameAudio(
    String idAudio,
    String newNameAudio,
    String newAudioUrl,
    String newDuration,
    String newDateTime,
    List newSearchName,
    List collections,
    bool newDone,
  ) async {
    final model = AudioModel(
        id: idAudio,
        audioName: newNameAudio,
        audioUrl: newAudioUrl,
        duration: newDuration,
        done: newDone,
        searchName: newSearchName,
        dateTime: newDateTime,
        collections: collections);

    final json = model.toJson();

    FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection('Collections')
        .doc(idAudio)
        .update(json);
  }
}
