import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/screens/screens_element/appbar_clipper.dart';
import 'package:memory_box/screens/screens_element/button_continue.dart';
import 'package:memory_box/screens/screens_element/container_shadow.dart';
import 'package:memory_box/screens/screens_element/textfield_input.dart';

import '../constants.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);
  late final String _phoneNumber = '+3(066) 123 45 67';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _AppbarHeader(),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Введи номер телефона',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldInput(phoneNumber: _phoneNumber),
            const SizedBox(
              height: 60,
            ),
            ButtonContinue(onPressed: () {
              Navigator.pushNamed(context, '/RegistrationPage');
            }),
            const SizedBox(
              height: 15,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/HomePage');
                },
                child: const Text(
                  'Позже',
                  style: TextStyle(
                    fontSize: 24,
                    color: kColorText,
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            const ContainerShadow()
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
        height: 250,
      ),
    );
  }
}
