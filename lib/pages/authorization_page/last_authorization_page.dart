import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/home_page.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/container_shadow.dart';

class LastAuthorizationPage extends StatefulWidget {
  const LastAuthorizationPage({Key? key}) : super(key: key);
  static const rootName = '/last_authorization_page';

  @override
  State<LastAuthorizationPage> createState() => _LastAuthorizationPageState();
}

class _LastAuthorizationPageState extends State<LastAuthorizationPage> {
  final bool shouldPop = false;
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, HomePage.rootName);
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
            const _AppbarHeader(),
            const SizedBox(
              height: 40.0,
            ),
            const ContainerShadow(
                width: 300,
                height: 80,
                widget: Text(
                  'Мы рады тебя видеть',
                  style: kBodiTextStyle,
                ),
                radius: 20),
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

class _AppbarHeader extends StatelessWidget {
  const _AppbarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: AppbarClipper(),
        child: Container(
          child: const Center(
            child: Text(
              'Ты супер!',
              style: kTitleTextStyle,
            ),
          ),
          color: AppColor.colorAppbar,
          width: double.infinity,
          height: 285.0,
        ));
  }
}
