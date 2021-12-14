import 'package:flutter/material.dart';
import 'package:memory_box/screens/first_page.dart';
import 'package:memory_box/screens/registration_page.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MemoryBox',
      theme: ThemeData(
          textTheme: const TextTheme(
              bodyText2: TextStyle(
                  color: kColorText,
                  fontFamily: 'TTNorm',
                  fontWeight: FontWeight.normal))),
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstPage(),
        '/RegistrationPage': (context) => RegistrationPage(),
      },
    );
  }
}
