import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:memory_box/pages/authorization_pages/last_authorization_page.dart';
import 'package:memory_box/pages/authorization_pages/registration_page/registration_page_%20model.dart';
import 'package:memory_box/pages/authorization_pages/registration_page/widget/text_field_captcha.dart';
import 'package:memory_box/pages/main_page.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/button/button_continue.dart';
import 'package:memory_box/widgets/uncategorized/container_shadow.dart';
import 'package:memory_box/widgets/uncategorized/textfield_input.dart';
import 'package:provider/provider.dart';

import '../../../widgets/uncategorized/appbar/appbar_header_authorization.dart';

enum MobileVerificationState {
  showMobileFormState,
  showOtpFormState,
}

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);
  static const routeName = '/registration_page';

  static Widget create() {
    return RegistrationPage();
  }

  @override
  State<RegistrationPage> createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  MobileVerificationState currentState =
      MobileVerificationState.showMobileFormState;

  // bool currentState = true;

  final phoneController = TextEditingController();

  final otpController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? verificationId;

  bool showLoading = false;

  void _singInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
        if (authCredential.user != null) {
          Navigator.pushNamed(context, LastAuthorizationPage.routeName);
        }
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );
    }
  }

  _getMobileFormWidget(context) {
    // final showLoading =
    //     Provider.of<RegistrationPageModel>(context, listen: false)
    //         .getShowLoading;
    return Column(
      children: [
        const Text(
          '?????????? ?????????? ????????????????',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextFieldInput(
              controller: phoneController,
            )),
        const SizedBox(
          height: 30.0,
        ),
        ButtonContinue(
          // onPressed: () =>
          //     Provider.of<RegistrationPageModel>(context, listen: false)
          //         .buttonContinue(context, phoneController),
          onPressed: () async {
            setState(() {
              showLoading = true;
            });
            await _auth.verifyPhoneNumber(
              phoneNumber: phoneController.text,
              verificationCompleted: (phoneAuthCredential) async {
                setState(() {
                  showLoading = false;
                });
                // singInWithPhoneAuthCredential(phoneAuthCredential);
              },
              verificationFailed: (verificationFailed) async {
                setState(() {
                  showLoading = false;
                });
                _scaffoldKey.currentState!.showSnackBar(
                  SnackBar(
                    content: Text(verificationFailed.message!),
                  ),
                );
              },
              codeSent: (verificationId, resendingToken) async {
                setState(() {
                  showLoading = false;
                  currentState = MobileVerificationState.showOtpFormState;
                  this.verificationId = verificationId;
                });
              },
              codeAutoRetrievalTimeout: (verificationId) async {},
            );
          },
          text: '????????????????????',
        ),
      ],
    );
  }

  _getOtpFormWidget(context) {
    return Column(
      children: [
        const Text(
          '?????????? ?????? ???? ??????, ?????????? ???? \n ???????? ??????????????????',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFieldCaptcha(
          controller: otpController,
        ),
        const SizedBox(
          height: 30.0,
        ),
        ButtonContinue(
          onPressed: () {
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId!,
                    smsCode: otpController.text);
            // Provider.of<RegistrationPageModel>(context, listen: false)
            //     .singInWithPhoneAuthCredential(context, phoneAuthCredential);
            _singInWithPhoneAuthCredential(phoneAuthCredential);
          },
          text: '????????????????????',
        ),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // final showLoading =
    //     Provider.of<RegistrationPageModel>(context, listen: false)
    //         .getShowLoading;
    //
    // final currentState =
    //     Provider.of<RegistrationPageModel>(context, listen: false)
    //         .getCurrentState;
    // print(currentState);
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppbarHeaderAuthorization(
              title: '??????????????????????',
              subtitle: '',
            ),
            const SizedBox(
              height: 15.0,
            ),
            showLoading
                ? const CircularProgressIndicator()
                : currentState == MobileVerificationState.showMobileFormState
                    ? _getMobileFormWidget(context)
                    : _getOtpFormWidget(context),
            const SizedBox(
              height: 15.0,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Main.routeName);
                },
                child: const Text(
                  '??????????',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: AppColor.colorText,
                  ),
                )),
            const SizedBox(
              height: 10.0,
            ),
            const ContainerShadow(
              image: Text(''),
              width: 275.0,
              height: 100.0,
              radius: 20.0,
              widget: Text(
                '?????????????????????? ???????????????? ???????? ???????????? ?? ????????????, ?????????? ???????? ?????? ???????????? ?????????? ?? ??????????',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
