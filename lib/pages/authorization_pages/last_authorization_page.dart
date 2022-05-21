import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:memory_box/widgets/uncategorized/container_shadow.dart';
import '../../widgets/uncategorized/appbar/appbar_header_authorization.dart';

class LastAuthorizationPage extends StatefulWidget {
  const LastAuthorizationPage({Key? key}) : super(key: key);
  static const routeName = '/last_authorization_page';

  @override
  State<LastAuthorizationPage> createState() => _LastAuthorizationPageState();
}

class _LastAuthorizationPageState extends State<LastAuthorizationPage> {
  final bool shouldPop = false;
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
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
        body: SingleChildScrollView(
          child: Column(
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
                  style: kBodyTextStyle,
                ),
                radius: 20.0,
              ),
              const SizedBox(
                height: 50.0,
              ),
              Image.asset(
                AppIcons.heart,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
