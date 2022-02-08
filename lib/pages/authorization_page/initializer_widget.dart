import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/authorization_page/first_authorization_page.dart';
import 'package:memory_box/pages/authorization_page/first_page.dart';

class _InitializerWidgetArguments {
  _InitializerWidgetArguments({this.auth, this.user, this.isLoading}) {
    init();
  }
  FirebaseAuth? auth;
  User? user;
  bool? isLoading = true;

  void init() {
    auth = FirebaseAuth.instance;
    user = auth!.currentUser;
    isLoading = false;
  }
}

class InitializerWidget extends StatelessWidget {
  InitializerWidget({Key? key}) : super(key: key);
  static const rootName = 'initializer_widget';
  final _InitializerWidgetArguments arguments = _InitializerWidgetArguments();

  @override
  Widget build(BuildContext context) {
    return arguments.isLoading!
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : arguments.user == null
            ? FirstPage()
            : const FirstAuthorizationPage();
  }
}
