import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/initializer_widget.dart';
import 'package:memory_box/pages/authorization_page/registration_page.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/button_continue.dart';

import '../../resources/constants.dart';

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);
  static const rootName = '/';
  bool shouldPop = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Scaffold(
        body: Column(
          children: [
            _AppbarHeader(),
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

class _AppbarHeader extends StatelessWidget {
  const _AppbarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: AppbarClipper(),
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: const Text(
                      'MemoryBox',
                      style: kTitleTextStyle,
                    ),
                  ),
                ),
                const Text(
                  'Твой голос всегда рядом',
                  style: kTitle2TextStyle,
                )
              ],
            ),
          ),
          color: AppColor.colorAppbar,
          width: double.infinity,
          height: 285.0,
        ));
  }
}
