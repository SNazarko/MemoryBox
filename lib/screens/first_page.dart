import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/data_model_user.dart';
import 'package:memory_box/models/preferences_data_model_user.dart';
import 'package:memory_box/screens/screens_element/appbar_clipper.dart';
import 'package:memory_box/screens/screens_element/button_continue.dart';

import '../resources/constants.dart';

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Navigator.pushNamed(context, '/RegistrationPage');
          })
        ],
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
              children: const [
                Text(
                  'MemoryBox',
                  style: kTitleTextStyle,
                ),
                Text(
                  'Твой голос всегда рядом',
                  style: kTitle2TextStyle,
                )
              ],
            ),
          ),
          color: kColorAppbar,
          width: double.infinity,
          height: 285.0,
        ));
  }
}
