import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/authorization_page/last_authorization_page.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/pages/home_page.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/button_continue.dart';
import 'package:memory_box/widgets/container_shadow.dart';
import 'package:memory_box/widgets/textfield_input.dart';
import '../../resources/constants.dart';

enum MobileVerificationState {
  showMobileFormState,
  showOtpFormState,
}

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);
  static const rootName = '/registration_page';

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  MobileVerificationState currentState =
      MobileVerificationState.showMobileFormState;

  final phoneController = TextEditingController();

  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String? verificationId;

  bool showLoading = false;

  void singInWithPhoneAuthCredential(
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
          Navigator.pushNamed(context, LastAuthorizationPage.rootName);
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

  getMobileFormWidget(context) {
    return Column(
      children: [
        const Text(
          'Введи номер телефона',
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
          height: 50.0,
        ),
        ButtonContinue(onPressed: () async {
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
        }),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        const Text(
          'Введи код из смс, чтобы мы \n тебя запомнили',
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
          height: 50.0,
        ),
        ButtonContinue(onPressed: () {
          PhoneAuthCredential phoneAuthCredential =
              PhoneAuthProvider.credential(
                  verificationId: verificationId!, smsCode: otpController.text);
          singInWithPhoneAuthCredential(phoneAuthCredential);
        }),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _AppbarHeader(),
            const SizedBox(
              height: 20.0,
            ),
            showLoading
                ? CircularProgressIndicator()
                : currentState == MobileVerificationState.showMobileFormState
                    ? getMobileFormWidget(context)
                    : getOtpFormWidget(context),

            // const Text(
            //   'Введи номер телефона',
            //   style: TextStyle(
            //     fontSize: 16.0,
            //   ),
            // ),
            // const SizedBox(
            //   height: 15.0,
            // ),
            // TextFieldInput(),
            // const SizedBox(
            //   height: 60.0,
            // ),
            // ButtonContinue(onPressed: () {}),
            const SizedBox(
              height: 15.0,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomePage.rootName);
                },
                child: const Text(
                  'Позже',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: AppColor.colorText,
                  ),
                )),
            const SizedBox(
              height: 15.0,
            ),
            const ContainerShadow(
              width: 275.0,
              height: 100.0,
              radius: 20.0,
              widget: Text(
                'Регистрация привяжет твои сказки к облаку, после чего они всегда будут с тобой',
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

class _AppbarHeader extends StatelessWidget {
  const _AppbarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AppbarClipper(),
      child: Container(
        child: const Center(
            child: Text(
          'Регистрация',
          style: kTitleTextStyle,
        )),
        color: AppColor.colorAppbar,
        width: double.infinity,
        height: 285.0,
      ),
    );
  }
}

class TextFieldCaptcha extends StatelessWidget {
  const TextFieldCaptcha({Key? key, this.controller}) : super(key: key);
  final controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 275.0,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(30.0),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0.0, 5.0),
              blurRadius: 5.0,
            )
          ]),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(
            color: Colors.black,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}