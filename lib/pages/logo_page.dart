import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:memory_box/pages/screensaver_page.dart';
import 'package:memory_box/resources/app_colors.dart';

import 'first_page.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({Key? key}) : super(key: key);
  static const rootName = 'logo_page';

  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      Navigator.pushNamed(context, Screensaver.rootName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF8077E4),
      ),
    );
  }
}
