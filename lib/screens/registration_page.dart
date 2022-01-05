import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/screens/screens_element/appbar_clipper.dart';
import 'package:memory_box/screens/screens_element/button_continue.dart';
import 'package:memory_box/screens/screens_element/container_shadow.dart';
import 'package:memory_box/screens/screens_element/textfield_input.dart';

import '../constants.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _AppbarHeader(),
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              'Введи номер телефона',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextFieldInput(),
            const SizedBox(
              height: 60.0,
            ),
            ButtonContinue(onPressed: () {
              Navigator.pushNamed(context, '/RegistrationPage');
            }),
            const SizedBox(
              height: 15.0,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/HomePage');
                },
                child: const Text(
                  'Позже',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: kColorText,
                  ),
                )),
            const SizedBox(
              height: 15.0,
            ),
            const ContainerShadow(
              width: 275.0,
              height: 100.0,
              radius: 20.0,
              text:
                  'Регистрация привяжет твои сказки к облаку, после чего они всегда будут с тобой',
            )
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
          'Регистрация',
          style: kTitleTextStyle,
        )),
        color: kColorAppbar,
        width: double.infinity,
        height: 285.0,
      ),
    );
  }
}
