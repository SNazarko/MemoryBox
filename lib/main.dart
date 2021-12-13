import 'package:flutter/material.dart';
import 'package:memory_box/screens/first_page.dart';

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
                  color: Color(0xFF3A3A55),
                  fontFamily: 'TTNorms',
                  fontWeight: FontWeight.bold))),
      home: const FirstPage(),
    );
  }
}
