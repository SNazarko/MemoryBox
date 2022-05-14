import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:memory_box/models/user_model.dart';
import 'package:memory_box/repositories/auth_repositories.dart';
import 'package:uuid/uuid.dart';

import '../models/shat_model.dart';

class UserRepositories {
  UserRepositories._();

  static final UserRepositories instance = UserRepositories._();

  final phoneNumber = AuthRepositories.instance.user!.phoneNumber!;
  var uuid = const Uuid();

  //Stream list user

  Stream<List<UserModel>> readUser() => FirebaseFirestore.instance
      .collection(phoneNumber)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());

  //Stream list support user shat

  Stream<List<ShatModel>> readUserShat() => FirebaseFirestore.instance
      .collection('SupportQuestions')
      .orderBy('dateTime', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => ShatModel.fromJson(doc.data())).toList());

  // Basic filling of the database at the first event

  // Future<void> firstAuthorization() async {
  //   final DateTime now = DateTime.now();
  //   final DateTime later = now.add(const Duration(days: 30));
  //   final Timestamp laterTimestamp = Timestamp.fromDate(later);
  //   await FirebaseFirestore.instance
  //       .collection(user!.phoneNumber!)
  //       .doc('user')
  //       .set({
  //     'displayName': 'Имя',
  //     'phoneNumb': '+00(000)0000000',
  //     'avatarUrl': '',
  //     'onceAMonth': false,
  //     'onceAYear': false,
  //     'onlyMonth': false,
  //     'finishTimeSubscription': laterTimestamp,
  //     'subscription': true,
  //     'subscriptionLimit': 524288000,
  //     'totalQuality': 0,
  //     'totalSize': 0,
  //     'totalTime': '00:00',
  //   });
  // }

  // Update size repositories
  Future<void> updateSizeRepositories(int size) async {
    FirebaseFirestore.instance
        .collection(phoneNumber)
        .doc('user')
        .update({'totalSize': FieldValue.increment(size)});
  }

  // Update total time quality

  Future<void> updateTotalTimeQuality() async {
    final List quality = [];
    final List<int> duration = <int>[];
    var sum = 0;

    await FirebaseFirestore.instance
        .collection(phoneNumber)
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
        .collection(phoneNumber)
        .doc('user')
        .update({
      'totalQuality': duration.length,
      'totalTime': '$hour:$minutes',
    });
  }

  // Update name & number phone

  Future<void> updateNameNumber(
      String name, String number, String image) async {
    await FirebaseFirestore.instance
        .collection(phoneNumber)
        .doc('user')
        .update({
      'displayName': name,
      'phoneNumb': number,
      'avatarUrl': image,
    });
  }

  // Update image

  Future<String> uploadImage(XFile image) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('$phoneNumber/userImage/${getImageName(image)}');
    await ref.putFile(File(image.path));
    UserModel(avatarUrl: '${ref.getDownloadURL()}');
    return ref.getDownloadURL();
  }

  String getImageName(XFile image) {
    return image.path.split('/').last;
  }

  // Delete account from firebase

  Future<void> deleteAccount() async {
    final model = UserModel(
        displayName: 'Имя', phoneNumb: '+00(000)0000000', avatarUrl: '');
    final json = model.toJson();
    await FirebaseFirestore.instance
        .collection(phoneNumber)
        .doc('user')
        .set(json);
  }

  // Limit not Subscription

  Future<void> limitNotSubscription() async {
    final now = Timestamp.now();
    if (AuthRepositories.instance.user != null) {
      await FirebaseFirestore.instance
          .collection(phoneNumber)
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          final Timestamp finishTimeSubscription =
              result.data()['finishTimeSubscription'] ?? now;
          final state = finishTimeSubscription.compareTo(now);
          if (state >= 0) {
            FirebaseFirestore.instance
                .collection(phoneNumber)
                .doc('user')
                .update({
              'subscriptionLimit': 524288000000000,
            });
          } else {
            FirebaseFirestore.instance
                .collection(phoneNumber)
                .doc('user')
                .update({
              'subscriptionLimit': 524288000,
            });
            FirebaseFirestore.instance
                .collection(phoneNumber)
                .doc('user')
                .update({
              'onceAMonth': false,
              'onceAYear': false,
            });
          }
        }
      });
      await FirebaseFirestore.instance
          .collection(phoneNumber)
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          final int totalSize = result.data()['totalSize'] ?? 0;
          final int subscriptionLimit = result.data()['subscriptionLimit'] ?? 0;
          if (totalSize >= subscriptionLimit) {
            FirebaseFirestore.instance
                .collection(phoneNumber)
                .doc('user')
                .update({
              'subscription': false,
            });
          }
          if (totalSize < subscriptionLimit) {
            FirebaseFirestore.instance
                .collection(phoneNumber)
                .doc('user')
                .update({
              'subscription': true,
            });
          }
        }
      });
    }
  }

  // Subscription for a certain number of days

  Future<void> subscription(int days) async {
    final DateTime now = DateTime.now();
    final DateTime later = now.add(Duration(days: days));
    final Timestamp laterTimestamp = Timestamp.fromDate(later);
    FirebaseFirestore.instance.collection(phoneNumber).doc('user').update({
      'finishTimeSubscription': laterTimestamp,
    });
  }

  // Subscription done

  Future<void> subscriptionDone(String name, bool done) async {
    FirebaseFirestore.instance.collection(phoneNumber).doc('user').update({
      name: done,
    });
  }

  //support_message_page

  Future<void> supportQuestions(String questions) async {
    final Timestamp now = Timestamp.now();
    FirebaseFirestore.instance
        .collection('SupportQuestions')
        .doc(uuid.v1())
        .set({
      'phoneNumber': phoneNumber,
      'message': questions,
      'dateTime': now,
    });
  }
}
