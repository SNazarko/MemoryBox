import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/repositories/auth_repositories.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

import 'collections_repositories.dart';

class AudioRepositories {
  AudioRepositories._();

  static final AudioRepositories instance = AudioRepositories._();

  final phoneNumber = AuthRepositories.instance.user!.phoneNumber!;
  final uuid = const Uuid();

  Stream<List<AudioModel>> readAudio(String sort, String collection) =>
      FirebaseFirestore.instance
          .collection(phoneNumber)
          .doc('id')
          .collection(collection)
          .where('collections', arrayContains: sort)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => AudioModel.fromJson(doc.data()))
              .toList());

  //Stream play list delete audio

  Stream<List<AudioModel>> readAudioDelete(String sort) => FirebaseFirestore
      .instance
      .collection(phoneNumber)
      .doc('id')
      .collection('DeleteCollections')
      .where('collections', arrayContains: sort)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AudioModel.fromJson(doc.data())).toList());

  //Stream play list audio

  Stream<List<AudioModel>> readAudioSort(String sort) => FirebaseFirestore
      .instance
      .collection(phoneNumber)
      .doc('id')
      .collection('Collections')
      .where('collections', arrayContains: sort)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AudioModel.fromJson(doc.data())).toList());

// Save audio file in firebase

  Future<void> addAudio(
    String path,
    String name,
    String duration,
    Set searchName,
  ) async {
    var id = uuid.v1();
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('$phoneNumber/userAudio/$id.m4a');
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
    await UserRepositories.instance.updateSizeRepositories(size);
    await FirebaseFirestore.instance
        .collection(phoneNumber)
        .doc('id')
        .collection('Collections')
        .doc(id)
        .set(json);
  }

  //Add audio in collection

  Future<void> addAudioCollections(String nameCollection, String idAudio,
      List collections, bool done) async {
    if (done == true) {
      collections.add(nameCollection);
    }
    if (done == false) {
      collections.remove(nameCollection);
    }

    FirebaseFirestore.instance
        .collection(phoneNumber)
        .doc('id')
        .collection('Collections')
        .doc(idAudio)
        .update({'collections': collections});
  }

  // Rename audio file in firebase

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
        .collection(phoneNumber)
        .doc('id')
        .collection('Collections')
        .doc(idAudio)
        .update(json);
  }

  // Done in Audio

  Future<void> doneAudioItem(
      String idAudio, bool done, String collectionFire) async {
    FirebaseFirestore.instance
        .collection(phoneNumber)
        .doc('id')
        .collection(collectionFire)
        .doc(idAudio)
        .update({'done': done});
  }

  // Share audio file

  Future<void> downloadAudio(String idAudio, String name) async {
    Directory directory = await getTemporaryDirectory();
    final filePath = directory.path + '/$name.mp3';
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('$phoneNumber/userAudio/$idAudio.m4a')
          .writeToFile(File(filePath));
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Ошибка $e');
      }
    }
    await Share.shareFiles(
      [filePath],
    );
  }

  // Play/Pause in playing PlayerCollections

  Future<void> playPause(String idAudio, bool donePlay) async {
    FirebaseFirestore.instance
        .collection(phoneNumber)
        .doc('id')
        .collection('Collections')
        .doc(idAudio)
        .update({'playPause': donePlay});
  }

  // Delete files after 15 days
  Future<void> finishDelete() async {
    final now = DateTime.now();
    final later = now.add(const Duration(days: 15));
    String? idAudio;
    int? size;
    Timestamp? dateTimeDelete;
    if (AuthRepositories.instance.user != null) {
      await FirebaseFirestore.instance
          .collection(phoneNumber)
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
      if (dateTimeDelete != null) {
        final state = dateTimeDelete!.compareTo(Timestamp.fromDate(later));
        if (state >= 0) {
          await UserRepositories.instance.updateSizeRepositories(-size!);
          await CollectionsRepositories.instance
              .deleteCollectionApp(idAudio!, 'DeleteCollections');
        }
      }
    }
  }
}
