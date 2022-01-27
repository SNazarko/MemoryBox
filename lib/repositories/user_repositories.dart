import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:memory_box/players/sound_record.dart';

class UserRepositories {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<XFile?> singleImagePick() async {
    return await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 200,
      maxWidth: 200,
    );
  }

  Future<void> updateName(String name) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc('id');
    docUser.update({'name': name});
  }

  Future<void> updateNumber(String number) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc('id');
    docUser.update({'number': number});
  }

  Future<String> uploadImage(XFile image) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('userImage/${getImageName(image)}');
    await ref.putFile(File(image.path));
    return ref.getDownloadURL();
  }

  String getImageName(XFile image) {
    return image.path.split('/').last;
  }

  Future<void> deleteAccount() async {
    final docUser = FirebaseFirestore.instance.collection('user').doc('id');
    docUser.update(
      {
        'name': 'Имя',
        'number': '+00(000)0000000',
      },
    );
  }

  Future<String> uploadAudio(String name) async {
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref('userAudio/$name');
    final audioFile = SoundRecording().mPath;
    await ref.putFile(File(audioFile));
    print(ref.getDownloadURL());
    print(audioFile);
    return ref.getDownloadURL();
  }

  // String getAudioName(XFile file) {
  //   return file.path.split('/').last;
  // }
}
