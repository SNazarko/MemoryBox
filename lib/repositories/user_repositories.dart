import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:memory_box/models/user_model.dart';

class UserRepositories {
  UserRepositories() {
    init();
  }
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseAuth? auth;
  User? user;

  void init() {
    auth = FirebaseAuth.instance;
    user = auth!.currentUser;
  }

  Stream<List<UserModel>> readUser() => FirebaseFirestore.instance
      .collection(user!.phoneNumber!)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());

  Future<XFile?> singleImagePick() async {
    return await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );
  }

  Future<void> updateNameNumber(
      String name, String number, String image) async {
    final model =
        UserModel(displayName: name, phoneNumb: number, avatarUrl: image);
    final json = model.toJson();
    await FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('user')
        .set(json);
  }

  Future<String> uploadImage(XFile image) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('${user!.phoneNumber!}/userImage/${getImageName(image)}');
    await ref.putFile(File(image.path));
    UserModel(avatarUrl: '${ref.getDownloadURL()}');
    return ref.getDownloadURL();
  }

  String getImageName(XFile image) {
    return image.path.split('/').last;
  }

  Future<void> deleteAccount() async {
    final model = UserModel(
        displayName: 'Имя', phoneNumb: '+00(000)0000000', avatarUrl: '');
    final json = model.toJson();
    await FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('user')
        .set(json);
  }
}
