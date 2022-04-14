import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:memory_box/animation/screensaver_page/screensaver_page.dart';

class FirstWightPage extends StatefulWidget {
  const FirstWightPage({Key? key}) : super(key: key);
  static const routeName = '/logo_page';
  static Widget create() {
    return const FirstWightPage();
  }

  @override
  _FirstWightPageState createState() => _FirstWightPageState();
}

class _FirstWightPageState extends State<FirstWightPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      Navigator.pushNamed(context, Screensaver.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF8077E4),
      ),
    );
  }
}
