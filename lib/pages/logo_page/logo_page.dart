import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:memory_box/pages/logo_page/screensaver_page.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({Key? key}) : super(key: key);
  static const routeName = 'logo_page';
  static Widget create() {
    return const LogoPage();
  }

  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
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
