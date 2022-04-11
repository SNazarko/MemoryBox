import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/models/user_model.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

import 'collections_repositories.dart';

class AudioRepositories {
  AudioRepositories() {
    init();
  }
  UserModel userModel = UserModel();
  UserRepositories repositories = UserRepositories();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseAuth? auth;
  User? user;
  var uuid = const Uuid();

  void init() {
    auth = FirebaseAuth.instance;
    user = auth!.currentUser;
  }

  Stream<List<AudioModel>> readAudioDelete(String sort) => FirebaseFirestore
      .instance
      .collection(user!.phoneNumber!)
      .doc('id')
      .collection('DeleteCollections')
      .where('collections', arrayContains: sort)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AudioModel.fromJson(doc.data())).toList());

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
        .ref('${user!.phoneNumber!}/userAudio/$id.m4a');
    await ref.putFile(File(path));
    final file = File(path);
    final statFile = await file.stat();
    final size = statFile.size;
    final _todayDate = DateTime.now();
    final _todayDate2 = Timestamp.now();
    final model = AudioModel(
      collections: ['all'],
      id: id,
      audioName: name,
      audioUrl: await ref.getDownloadURL(),
      duration: duration,
      dateTime: formatDate(
          _todayDate, [dd, '.', mm, '.', yy, HH, ':', nn, ':', ss, z]),
      dateTimeDelete: _todayDate2,
      done: false,
      playPause: false,
      searchName: searchName.toList(),
      size: size,
    );
    final json = model.toJson();
    await repositories.updateSizeRepositories(size);
    await FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection('Collections')
        .doc(id)
        .set(json);
  }

  Future<void> downloadAudio(String idAudio, String name) async {
    Directory directory = await getTemporaryDirectory();
    final filePath = directory.path + '/$name.mp3';
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('${user!.phoneNumber!}/userAudio/$idAudio.m4a')
          .writeToFile(File(filePath));
    } on FirebaseException catch (e) {
      print('Ошибка $e');
    }
    await Share.shareFiles(
      [filePath],
    );
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

  void finishDelete() async {
    final now = DateTime.now();
    final later = now.add(const Duration(days: 15));
    String? idAudio;
    int? size;
    Timestamp? dateTimeDelete;
    await FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection('DeleteCollections')
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        dateTimeDelete = result.data()['dateTimeDelete'];
        idAudio = result.data()['id'];
        size = result.data()['size'];
      }
    });
    final state = dateTimeDelete!.compareTo(Timestamp.fromDate(later));
    if (state >= 0) {
      await repositories.updateSizeRepositories(-size!);
      await CollectionsRepositories()
          .deleteCollection(idAudio!, 'DeleteCollections');
    }
  }

  Future<void> playPause(String idAudio, bool donePlay) async {
    FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection('Collections')
        .doc(idAudio)
        .update({'playPause': donePlay});
  }
}
