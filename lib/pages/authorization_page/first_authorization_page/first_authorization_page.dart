import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/authorization_page/first_authorization_page/widgets/appbar_header.dart';
import 'package:memory_box/pages/home_page.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/container_shadow.dart';

class _FirstAuthorizationPageArguments {
  _FirstAuthorizationPageArguments({this.shouldPop});
  bool? shouldPop = false;
}

class FirstAuthorizationPage extends StatefulWidget {
  const FirstAuthorizationPage({Key? key}) : super(key: key);
  static const rootName = '/first_authorization_page';

  @override
  State<FirstAuthorizationPage> createState() => _FirstAuthorizationPageState();
}

class _FirstAuthorizationPageState extends State<FirstAuthorizationPage> {
  _FirstAuthorizationPageArguments arguments =
      _FirstAuthorizationPageArguments();

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
        return arguments.shouldPop!;
      },
      child: Scaffold(
        body: Column(
          children: [
            const AppbarHeader(),
            const SizedBox(
              height: 40.0,
            ),
            const ContainerShadow(
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
            const SizedBox(
              height: 50.0,
            ),
            const ContainerShadow(
                width: 250.0,
                height: 75.0,
                widget: Text(
                  'Взрослые иногда нуждаются в \n сказке даже больше, чем дети',
                  style: kBodi2TextStyle,
                ),
                radius: 20.0),
          ],
        ),
      ),
    );
  }
}
