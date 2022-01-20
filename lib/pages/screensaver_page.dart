import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screensaver extends StatefulWidget {
  const Screensaver({Key? key}) : super(key: key);
  static const rootName = 'screensaver_page';

  @override
  _ScreensaverState createState() => _ScreensaverState();
}

class _ScreensaverState extends State<Screensaver> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFFF1B488), Color(0xFF8077E4)],
                begin: Alignment.bottomLeft),
            color: Colors.cyan,
          ),
        ),
      ],
    );
  }
}
