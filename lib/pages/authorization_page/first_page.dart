import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/authorization_page/registration_page.dart';
import 'package:memory_box/widgets/button_continue.dart';
import 'first_authorization_page/widgets/appbar_header.dart';

class _FirstPageArguments {
  _FirstPageArguments({this.shouldPop});
  bool? shouldPop = false;
}

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);
  static const rootName = '/';
  final _FirstPageArguments _arguments = _FirstPageArguments();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _arguments.shouldPop!;
      },
      child: Scaffold(
        body: Column(
          children: [
            const AppbarHeader(),
            const SizedBox(
              height: 40.0,
            ),
            const Text(
              'Привет!',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 55.0,
              ),
              child: Text(
                'Мы рады видеть тебя здесь. Это приложение поможет записывать сказки и держать их в удобном месте не заполняя память на телефоне.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ButtonContinue(onPressed: () {
              Navigator.pushNamed(context, RegistrationPage.rootName);
            })
          ],
        ),
      ),
    );
  }
}
