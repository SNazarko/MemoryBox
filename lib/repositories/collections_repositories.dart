import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:memory_box/models/collections_model.dart';
import 'package:memory_box/models/user_model.dart';

class CollectionsRepositories {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<XFile?> singleImagePick() async {
    return await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 200,
      maxWidth: 200,
    );
  }

  Future<void> addCollections(
    String titleCollections,
    String subTitleCollections,
    String avatarCollections,
  ) async {
    final model = CollectionsModel(
      titleCollections: titleCollections,
      subTitleCollections: subTitleCollections,
      avatarCollections: avatarCollections,
    );
    final json = model.toJson();
    FirebaseFirestore.instance.collection('CollectionsTale').doc().set(json);
  }
}
