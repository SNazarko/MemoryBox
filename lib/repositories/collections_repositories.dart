import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart';
import 'package:memory_box/models/collections_model.dart';
import 'package:memory_box/repositories/auth_repositories.dart';
import 'package:uuid/uuid.dart';

class CollectionsRepositories {
  CollectionsRepositories._();

  static final CollectionsRepositories instance = CollectionsRepositories._();

  final phoneNumber = AuthRepositories.instance.user!.phoneNumber!;
  final uuid = const Uuid();

  // Stream list collections

  Stream<List<CollectionsModel>> readCollections() => FirebaseFirestore.instance
      .collection(phoneNumber)
      .doc('id')
      .collection('CollectionsTale')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => CollectionsModel.fromJson(doc.data()))
          .toList());

  // Add Collections in Firebase

  Future<void> addCollections(String titleCollections,
      String subTitleCollections, String avatarCollections, id) async {
    final _todayDate = DateTime.now();
    final model = CollectionsModel(
      id: id,
      qualityCollections: 0,
      titleCollections: titleCollections,
      subTitleCollections: subTitleCollections,
      avatarCollections: avatarCollections,
      dateTime: formatDate(_todayDate, [
        dd,
        '.',
        mm,
        '.',
        yy,
      ]),
      totalTime: '00:00',
      doneCollection: false,
    );
    final json = model.toJson();
    FirebaseFirestore.instance
        .collection(phoneNumber)
        .doc('id')
        .collection('CollectionsTale')
        .doc(id)
        .set(json);
  }

  // Delete file from Applications

  Future<void> deleteCollectionApp(
    String idCollection,
    String collectionFirestore,
  ) async {
    FirebaseFirestore.instance
        .collection(phoneNumber)
        .doc('id')
        .collection(collectionFirestore)
        .doc(idCollection)
        .delete();
    try {
      firebase_storage.FirebaseStorage.instance
          .ref('$phoneNumber/userAudio/$idCollection.m4a')
          .delete();
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Delete file from collections
  Future<void> deleteCollection(
    String idCollection,
    String collectionFirestore,
  ) async {
    FirebaseFirestore.instance
        .collection(phoneNumber)
        .doc('id')
        .collection(collectionFirestore)
        .doc(idCollection)
        .delete();
  }

  // Done in collections

  Future<void> doneCollections(String idCollection, bool doneCollection) async {
    FirebaseFirestore.instance
        .collection(phoneNumber)
        .doc('id')
        .collection('CollectionsTale')
        .doc(idCollection)
        .update({'doneCollection': doneCollection});
  }

  // Copy collections

  Future<void> copyPastCollections(
    String idCollection,
    String fromTheCollection,
    String inTheCollection,
  ) async {
    final _todayDate2 = Timestamp.now();
    await FirebaseFirestore.instance
        .collection(phoneNumber)
        .doc('id')
        .collection(fromTheCollection)
        .where('id', isEqualTo: idCollection)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        FirebaseFirestore.instance
            .collection(phoneNumber)
            .doc('id')
            .collection(inTheCollection)
            .doc(idCollection)
            .set(result.data());
      }
    });
    Timer(const Duration(seconds: 5), () {
      FirebaseFirestore.instance
          .collection(phoneNumber)
          .doc('id')
          .collection(inTheCollection)
          .doc(idCollection)
          .update({
        'dateTimeDelete': _todayDate2,
        'done': false,
      });
    });
  }

  // Update Quality And Total Time

  Future<void> updateQualityAndTotalTime(String idCollection) async {
    final List quality = [];
    final List<int> duration = <int>[];
    var sum = 0;

    await FirebaseFirestore.instance
        .collection(phoneNumber)
        .doc('id')
        .collection('Collections')
        .where('collections', arrayContainsAny: [idCollection])
        .get()
        .then((querySnapshot) {
          for (var result in querySnapshot.docs) {
            final String time = result.data()['duration'];
            final collection = result.data();
            quality.add(collection);
            final timeTemp = time.replaceFirst(':', ',');
            final String minutes = timeTemp.split(',').elementAt(0);
            int minutesInt = int.tryParse(minutes) ?? 0;
            duration.add(minutesInt);
          }
        });
    for (int i = 0; i < duration.length; ++i) {
      sum = sum + duration[i];
    }
    String formatNumber(int number) {
      String numberStr = number.toString();
      if (number < 10) {
        numberStr = '0' + numberStr;
      }
      return numberStr;
    }

    final String hour = formatNumber(sum ~/ 60);
    final String minutes = formatNumber(sum % 60);
    await FirebaseFirestore.instance
        .collection(phoneNumber)
        .doc('id')
        .collection('CollectionsTale')
        .doc(idCollection)
        .update({
      'totalTime': '$hour:$minutes',
      'qualityCollections': duration.length,
    });
  }

  // update collection

  Future<void> updateCollection(
    String idCollection,
    String nameCollection,
    String subTitleCollections,
    String avatarCollections,
  ) async {
    final List quality = [];
    final List<int> duration = <int>[];
    var sum = 0;

    await FirebaseFirestore.instance
        .collection(phoneNumber)
        .doc('id')
        .collection('Collections')
        .where('collections', arrayContainsAny: [idCollection])
        .get()
        .then((querySnapshot) {
          for (var result in querySnapshot.docs) {
            final String time = result.data()['duration'];
            final collection = result.data();
            quality.add(collection);
            final timeTemp = time.replaceFirst(':', ',');
            final String minutes = timeTemp.split(',').elementAt(0);
            int minutesInt = int.tryParse(minutes) ?? 0;
            duration.add(minutesInt);
          }
        });
    for (int i = 0; i < duration.length; ++i) {
      sum = sum + duration[i];
    }
    String formatNumber(int number) {
      String numberStr = number.toString();
      if (number < 10) {
        numberStr = '0' + numberStr;
      }
      return numberStr;
    }

    final String hour = formatNumber(sum ~/ 60);
    final String minutes = formatNumber(sum % 60);
    final _todayDate = DateTime.now();
    final model = CollectionsModel(
      id: idCollection,
      qualityCollections: quality.length,
      titleCollections: nameCollection,
      subTitleCollections: subTitleCollections,
      avatarCollections: avatarCollections,
      dateTime: formatDate(_todayDate, [
        dd,
        '.',
        mm,
        '.',
        yy,
      ]),
      totalTime: '$hour:$minutes',
      doneCollection: false,
    );
    final json = model.toJson();
    await FirebaseFirestore.instance
        .collection(phoneNumber)
        .doc('id')
        .collection('CollectionsTale')
        .doc(idCollection)
        .update(json);
  }
}
