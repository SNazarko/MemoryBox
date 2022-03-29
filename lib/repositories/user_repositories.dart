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

  Future<void> updateSizeRepositories(int size) async {
    FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('user')
        .update({'size': FieldValue.increment(size)});
  }

  Future<void> updateTotalTimeQuality() async {
    final List quality = [];
    final List<int> duration = <int>[];
    var sum = 0;

    await FirebaseFirestore.instance
        .collection(user!.phoneNumber!)
        .doc('id')
        .collection('Collections')
        .where('collections', arrayContainsAny: ['all'])
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
        .doc('user')
        .update({
      'totalQuality': duration.length,
      'totalTime': '$hour:$minutes',
    });
  }

  Future<void> updateNameNumber(
      String name, String number, String image) async {
    final model = UserModel(
      displayName: name,
      phoneNumb: number,
      avatarUrl: image,
    );
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
