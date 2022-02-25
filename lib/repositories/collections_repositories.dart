import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/models/collections_model.dart';

class CollectionsRepositories {
  int documents = 0;
  Stream<List<CollectionsModel>> readCollections() => FirebaseFirestore.instance
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
    final QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection('CollectionsTale')
        .doc(nameCollection)
        .collection('Audio')
        .get();
    final int documents = qSnap.docs.length;
    final _todayDate = DateTime.now();
    final model = CollectionsModel(
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
        .collection('CollectionsTale')
        .doc(nameCollection)
        .set(json);
  }

  Future<void> addAudioForCollection(
    String nameCollection,
    String audioName,
    String audioUrl,
    String duration,
    bool done,
  ) async {
    final model = AudioModel(
      audioName: audioName,
      audioUrl: audioUrl,
      duration: duration,
      done: done,
    );
    final json = model.toJson();
    FirebaseFirestore.instance
        .collection('CollectionsTale')
        .doc(
          nameCollection,
        )
        .collection('Audio')
        .doc(audioName)
        .set(json);
  }

  Future<void> deleteAudioForCollection(
    String nameCollection,
    String audioName,
  ) async {
    FirebaseFirestore.instance
        .collection('CollectionsTale')
        .doc(
          nameCollection,
        )
        .collection('Audio')
        .doc(audioName)
        .delete();
  }

  Future<void> deleteCollection(
    String nameCollection,
  ) async {
    FirebaseFirestore.instance
        .collection('CollectionsTale')
        .doc(
          nameCollection,
        )
        .delete();
  }

  Future<void> doneCollections(
      String nameCollection, bool doneCollection) async {
    FirebaseFirestore.instance
        .collection('CollectionsTale')
        .doc(nameCollection)
        .update({'doneCollection': doneCollection});
  }

  Future<void> doneAudioItem(String nameCollection, bool done) async {
    FirebaseFirestore.instance
        .collection('CollectionsTale')
        .doc(nameCollection)
        .collection('Audio')
        .doc(nameCollection)
        .update({'done': done});
  }
}
