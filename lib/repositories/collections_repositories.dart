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

  Stream<List<CollectionsModel>> readCollections() => FirebaseFirestore.instance
      .collection(user!.phoneNumber!)
      .doc('id')
      .collection('CollectionsTale')
      .orderBy('data')
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
    final QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection('CollectionsTale')
        .doc(nameCollection)
        .collection('Audio')
        .get();
    final int documents = qSnap.docs.length;
    final _todayDate = DateTime.now();
    final model = CollectionsModel(
      id: id,
      qualityCollections: documents,
      titleCollections: titleCollections,
      subTitleCollections: subTitleCollections,
      avatarCollections: avatarCollections,
      data: formatDate(_todayDate, [
        dd,
        '.',
        mm,
        '.',
        yy,
      ]),
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
    String nameCollection,
    String collectionFirestore,
  ) async {
    FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection(collectionFirestore)
        .doc(nameCollection)
        .collection('Audio')
        .doc()
        .delete();
    FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection(collectionFirestore)
        .doc(nameCollection)
        .delete();
  }

  Future<void> doneCollections(
      String nameCollection, bool doneCollection) async {
    FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection('CollectionsTale')
        .doc(nameCollection)
        .update({'doneCollection': doneCollection});
  }

  Future<void> copyPastCollections(
    String nameCollection,
    String fromTheCollection,
    String inTheCollection,
  ) async {
    FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection(fromTheCollection)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        FirebaseFirestore.instance
            .collection(user!.phoneNumber!)
            .doc('id')
            .collection(inTheCollection)
            .doc(nameCollection)
            .set(result.data());
      });
    });
    FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection(fromTheCollection)
        .doc(nameCollection)
        .collection('Audio')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        FirebaseFirestore.instance
            .collection(user!.phoneNumber!)
            .doc('id')
            .collection(inTheCollection)
            .doc(nameCollection)
            .collection('Audio')
            .doc()
            .set(result.data());
      });
    });
  }

  Future<void> copyPastAudioCollections(
    String fromTheCollection,
    String inTheCollection,
  ) async {
    FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection('CollectionsTale')
        .doc(fromTheCollection)
        .collection('Audio')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        FirebaseFirestore.instance
            .collection(user!.phoneNumber!)
            .doc('id')
            .collection('CollectionsTale')
            .doc(inTheCollection)
            .collection('Audio')
            .doc()
            .set(result.data());
      });
    });
  }

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

  Future<void> updateCollection(
    String idCollection,
    String nameCollection,
    String subTitleCollections,
    String avatarCollections,
    // int qualityCollections,
  ) async {
    final _todayDate = DateTime.now();
    final model = CollectionsModel(
      id: idCollection,
      // qualityCollections: qualityCollections,
      titleCollections: nameCollection,
      subTitleCollections: subTitleCollections,
      avatarCollections: avatarCollections,
      data: formatDate(_todayDate, [
        dd,
        '.',
        mm,
        '.',
        yy,
      ]),
      doneCollection: false,
    );
    final json = model.toJson();
    FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection('CollectionsTale')
        .doc(idCollection)
        .update(json);
  }
}
