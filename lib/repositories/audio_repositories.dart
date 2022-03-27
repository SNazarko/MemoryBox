import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

import 'collections_repositories.dart';

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
    // .ref('${user!.phoneNumber!}/userAudio/${getAudioName(path)}');
    await ref.putFile(File(path));
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

  Future<void> downloadAudio(String idAudio, String name) async {
    Directory directory = await getTemporaryDirectory();
    final filePath = directory.path + '/$idAudio.mp3';
    var file = File(filePath);
    print('file$file');
    var fileTemp = await File('${directory.path}/$idAudio');
    print('fileTemp$fileTemp');
    var isExist = await file.exists();
    if (!isExist) {
      await file.create();
    }
    var rat = await fileTemp.readAsBytes();
    print('rat$rat');
    await file.writeAsBytes(rat);
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('${user!.phoneNumber!}/userAudio/$idAudio.m4a')
          .writeToFile(fileTemp);
    } on FirebaseException catch (e) {
      print('Ошибка $e');
    }

    await Share.shareFiles([filePath], text: name);
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
      }
    });
    final state = dateTimeDelete!.compareTo(Timestamp.fromDate(later));
    if (state >= 0) {
      CollectionsRepositories().deleteCollection(idAudio!, 'DeleteCollections');
    }
  }
}
