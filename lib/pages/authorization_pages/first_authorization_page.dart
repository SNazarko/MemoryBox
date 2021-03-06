import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:memory_box/widgets/uncategorized/container_shadow.dart';
import '../../widgets/uncategorized/appbar/appbar_header_authorization.dart';
import '../main_page.dart';

class FirstAuthorizationPage extends StatefulWidget {
  const FirstAuthorizationPage({Key? key}) : super(key: key);
  static const routeName = '/first_authorization_page';

  static Widget create() {
    return const FirstAuthorizationPage();
  }

  @override
  State<FirstAuthorizationPage> createState() => _FirstAuthorizationPageState();
}

class _FirstAuthorizationPageState extends State<FirstAuthorizationPage> {
  final bool shouldPop = false;

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, Main.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
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
            const SizedBox(
              height: 50.0,
            ),
            const ContainerShadow(
                image: Text(''),
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
