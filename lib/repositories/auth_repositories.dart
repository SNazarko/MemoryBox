import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositories {
  AuthRepositories._();
  static AuthRepositories? _instance;

  static AuthRepositories? get instance {
    _instance ??= AuthRepositories._();
    return _instance;
  }

  FirebaseAuth? _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneSendOtp(
    String phone, {
    void Function(PhoneAuthCredential)? completed,
    void Function(FirebaseAuthException)? failed,
    void Function(String, int?)? codeSent,
    void Function(String)? codeAutoRetrievalTimeout,
  }) async {
    await _auth?.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: completed!,
      verificationFailed: failed!,
      codeSent: codeSent!,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout!,
    );
  }

  Future<String> verifyAndLogin(
    String verificationId,
    String smsCode,
    String phone,
  ) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    final authCredential = await _auth!.signInWithCredential(credential);
    if (authCredential.user != null) {
      final DateTime now = DateTime.now();
      final DateTime later = now.add(const Duration(days: 30));
      final Timestamp laterTimestamp = Timestamp.fromDate(later);
      final uid = authCredential.user!.uid;
      final phoneNumber = authCredential.user!.phoneNumber;
      final userSnap = await FirebaseFirestore.instance
          .collection(phoneNumber!)
          .doc('user')
          .get();
      if (!userSnap.exists) {
        await FirebaseFirestore.instance
            .collection(phoneNumber)
            .doc('user')
            .set({
          'displayName': 'Имя',
          'phoneNumb': '+00(000)0000000',
          'avatarUrl': '',
          'onceAMonth': false,
          'onceAYear': false,
          'onlyMonth': false,
          'finishTimeSubscription': laterTimestamp,
          'subscription': true,
          'subscriptionLimit': 524288000,
          'totalQuality': 0,
          'totalSize': 0,
          'totalTime': '00:00',
        });
      }
      return uid;
    } else {
      return '';
    }
  }

  Future<String> getCredential(PhoneAuthCredential credential) async {
    final authCredential = await _auth!.signInWithCredential(credential);
    return authCredential.user!.uid;
  }
}
