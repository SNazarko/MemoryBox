import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/home_page.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/container_shadow.dart';

import '../../widgets/appbar_header_authorization.dart';

class _LastAuthorizationPageArguments {
  _LastAuthorizationPageArguments({this.shouldPop});
  bool? shouldPop = false;
}

class LastAuthorizationPage extends StatefulWidget {
  const LastAuthorizationPage({Key? key}) : super(key: key);
  static const rootName = '/last_authorization_page';

  @override
  State<LastAuthorizationPage> createState() => _LastAuthorizationPageState();
}

class _LastAuthorizationPageState extends State<LastAuthorizationPage> {
  final _LastAuthorizationPageArguments _arguments =
      _LastAuthorizationPageArguments();
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, HomePage.rootName);
    });
    super.initState();
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
              title: 'Ты супер!',
              subtitle: '',
            ),
            const SizedBox(
              height: 40.0,
            ),
            const ContainerShadow(
                image: Text(''),
                width: 300.0,
                height: 80.0,
                widget: Text(
                  'Мы рады тебя видеть',
                  style: kBodiTextStyle,
                ),
                radius: 20.0),
            const SizedBox(
              height: 50.0,
            ),
            Image.asset(AppIcons.heart),
          ],
        ),
      ),
    );
  }
}
