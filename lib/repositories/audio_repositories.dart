import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/models/user_model.dart';

class AudioRepositories {
  UserModel userModel = UserModel();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Stream<List<AudioModel>> readAudio() => FirebaseFirestore.instance
      .collection('Collections')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AudioModel.fromJson(doc.data())).toList());

  Future<void> uploadAudio(String path, String name, String duration) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('userAudio/${getAudioName(path)}');
    await ref.putFile(File(path));
    final model = AudioModel(
      audioName: name,
      audioUrl: '${await ref.getDownloadURL()}',
      duration: duration,
    );
    final json = model.toJson();
    FirebaseFirestore.instance.collection('Collections').doc().set(json);
  }

  String getAudioName(String name) {
    return name.split('/').last;
  }
}
