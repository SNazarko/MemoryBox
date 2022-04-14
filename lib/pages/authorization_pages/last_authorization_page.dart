import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/container_shadow.dart';
import '../../repositories/audio_repositories.dart';
import '../../repositories/user_repositories.dart';
import '../../widgets/appbar_header_authorization.dart';
import '../main_page.dart';

class LastAuthorizationPage extends StatefulWidget {
  const LastAuthorizationPage({Key? key}) : super(key: key);
  static const routeName = '/last_authorization_page';
  static Widget create() {
    return const LastAuthorizationPage();
  }

  @override
  State<LastAuthorizationPage> createState() => _LastAuthorizationPageState();
}

class _LastAuthorizationPageState extends State<LastAuthorizationPage> {
  final bool shouldPop = false;
  final UserRepositories repositories = UserRepositories();
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      // Navigator.pushNamed(context, Main.routeName);
      Phoenix.rebirth(context);
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
