import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/screens/screens_element/appbar_clipper.dart';
import 'package:memory_box/screens/screens_element/button_continue.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:memory_box/screens/screens_element/textfield_input.dart';

import '../constants.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);
  late final String _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
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
            ),
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
              height: 20,
            ),
            TextFieldInput(phoneNumber: _phoneNumber),
            const SizedBox(
              height: 60,
            ),
            ButtonContinue(onPressed: () {
              Navigator.pushNamed(context, '/RegistrationPage');
            }),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Позже',
                  style: TextStyle(
                    fontSize: 24,
                    color: kColorText,
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 55),
              child: Text(
                'Регистрация привяжет твои сказки к облаку, после чего они всегда будут с тобой',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
