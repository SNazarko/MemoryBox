import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/authorization_page/registration_page/registration_page.dart';
import 'package:memory_box/widgets/button_continue.dart';
import '../../widgets/appbar_header_authorization.dart';

class _FirstPageArguments {
  _FirstPageArguments({this.shouldPop});
  bool? shouldPop = false;
}

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);
  static const rootName = '/';
  final _FirstPageArguments _arguments = _FirstPageArguments();

  static Widget create() {
    return FirstPage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _arguments.shouldPop!;
      },
      child: Scaffold(
        body: Column(
          children: [
            const AppbarHeaderAuthorization(
              title: 'MemoryBox',
              subtitle: 'Твой голос всегда рядом',
            ),
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
