import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/authorization_pages/registration_page/registration_page.dart';
import 'package:provider/provider.dart';

import '../last_authorization_page.dart';

class RegistrationPageModel extends ChangeNotifier {
  bool _currentState = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _showLoading = true;
  String? _verificationId;

  get getShowLoading => _showLoading;
  get getVerificationId => _verificationId;
  get getCurrentState => _currentState;

  void setCurrentState(bool currentState) {
    _currentState = currentState;
    notifyListeners();
  }

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

  void buttonContinue(
      BuildContext context, TextEditingController phoneController) {
    _showLoading = true;
    notifyListeners();
    _auth.verifyPhoneNumber(
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
        print('11111');
        _currentState = false;
        _showLoading = false;
        Provider.of<RegistrationPageModel>(context, listen: false)
            .setCurrentState(_currentState);
        _verificationId = verificationId;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }
}
