import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/authorization_pages/registration_page/registration_page.dart';

import '../last_authorization_page.dart';

class RegistrationPageModel extends ChangeNotifier {
  MobileVerificationState currentState =
      MobileVerificationState.showMobileFormState;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _showLoading = false;
  String? verificationId;

  get getShowLoading => _showLoading;
  get getVerificationId => verificationId;
  get getCurrentState => currentState;

  void singInWithPhoneAuthCredential(
      BuildContext context, PhoneAuthCredential phoneAuthCredential) async {
    _showLoading = true;
    notifyListeners();
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      _showLoading = false;
      if (authCredential.user != null) {
        Navigator.pushNamed(context, LastAuthorizationPage.routeName);
      }
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _showLoading = false;
      notifyListeners();
    }
  }

  Future<void> buttonContinue(
      TextEditingController phoneController, currentState) async {
    _showLoading = true;
    notifyListeners();
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (phoneAuthCredential) async {
        _showLoading = false;
        notifyListeners();
        // singInWithPhoneAuthCredential(phoneAuthCredential);
      },
      verificationFailed: (verificationFailed) async {
        _showLoading = false;
        notifyListeners();
      },
      codeSent: (verificationId, resendingToken) async {
        _showLoading = false;
        notifyListeners();
        currentState = MobileVerificationState.showOtpFormState;
        this.verificationId = verificationId;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }
}
