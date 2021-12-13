import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/screens/screens_element/appbar_clipper.dart';
import 'package:memory_box/screens/screens_element/button_continue.dart';

import '../constants.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
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
              height: 250,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Привет!',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 55),
            child: Text(
              'Мы рады видеть тебя здесь. Это приложение поможет записывать сказки и держать их в удобном месте не заполняя память на телефоне.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ButtonContinue(
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
