import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memory_box/models/collections_model.dart';
import 'package:uuid/uuid.dart';

class CollectionsRepositories {
  CollectionsRepositories() {
    init();
  }
  var uuid = const Uuid();
  FirebaseAuth? auth;
  User? user;

  void init() {
    auth = FirebaseAuth.instance;
    user = auth!.currentUser;
  }

  Stream<List<CollectionsModel>> readCollectionsDelete() =>
      FirebaseFirestore.instance
          .collection(user!.phoneNumber!)
          .doc('id')
          .collection('CollectionsDelete')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => CollectionsModel.fromJson(doc.data()))
              .toList());

  Stream<List<CollectionsModel>> readCollections() => FirebaseFirestore.instance
      .collection(user!.phoneNumber!)
      .doc('id')
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
    var id = uuid.v1();
    FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection('CollectionsTale')
        .doc(nameCollection)
        .collection('Audio')
        .get();
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
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection('CollectionsTale')
        .doc(id)
        .set(json);
  }

  Future<void> deleteCollection(
    String idCollection,
    String collectionFirestore,
  ) async {
    FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection(collectionFirestore)
        .doc(idCollection)
        .delete();
  }

  Future<void> doneCollections(String idCollection, bool doneCollection) async {
    FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection('CollectionsTale')
        .doc(idCollection)
        .update({'doneCollection': doneCollection});
  }

  Future<void> copyPastCollections(
    String idCollection,
    String fromTheCollection,
    String inTheCollection,
  ) async {
    final _todayDate = DateTime.now();
    await FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection(fromTheCollection)
        .where('id', isEqualTo: idCollection)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        FirebaseFirestore.instance
            .collection(user!.phoneNumber!)
            .doc('id')
            .collection(inTheCollection)
            .doc(idCollection)
            .set(result.data());
      }
    });
    await FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection(inTheCollection)
        .doc(idCollection)
        .update({'dateTime': _todayDate});
  }

  // Future<void> copyPastAudioCollections(
  //   String fromTheCollection,
  //   String inTheCollection,
  // ) async {
  //
  //   FirebaseFirestore.instance
  //       .collection(user!.phoneNumber!)
  //       .doc('id')
  //       .collection('CollectionsTale')
  //       .doc(fromTheCollection)
  //       .collection('Audio')
  //       .get()
  //       .then((querySnapshot) {
  //     querySnapshot.docs.forEach((result) {
  //       FirebaseFirestore.instance
  //           .collection(user!.phoneNumber!)
  //           .doc('id')
  //           .collection('CollectionsTale')
  //           .doc(inTheCollection)
  //           .collection('Audio')
  //           .doc()
  //           .set(result.data());
  //     });
  //   });
  //
  // }

  Future<void> doneAudioItem(String idAudio, bool done) async {
    FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection('Collections')
        .doc(idAudio)
        .update({'done': done});
  }

  Future<void> addAudioCollections(String nameCollection, String idAudio,
      List collections, bool done) async {
    if (done == true) {
      collections.add(nameCollection);
    }
    if (done == false) {
      collections.remove(nameCollection);
    }

    FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection('Collections')
        .doc(idAudio)
        .update({'collections': collections});
  }

  Future<void> updateQualityAndTotalTime(String idCollection) async {
    final List quality = [];
    final List<int> duration = <int>[];
    var sum = 0;

    await FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
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
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection('CollectionsTale')
        .doc(idCollection)
        .update({
      'totalTime': '$hour:$minutes',
      'qualityCollections': duration.length,
    });
  }

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
        .collection(user!.phoneNumber!)
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
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection('CollectionsTale')
        .doc(idCollection)
        .update(json);
  }
}
