import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/first_page.dart';
import 'package:memory_box/pages/home_page.dart';
import 'package:memory_box/resources/app_colors.dart';

class Screensaver extends StatefulWidget {
  const Screensaver({Key? key}) : super(key: key);
  static const rootName = 'screensaver_page';

  @override
  _ScreensaverState createState() => _ScreensaverState();
}

class _ScreensaverState extends State<Screensaver>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller2;
  late Animation animation;
  late Animation animationColor;
  late Animation animationColor2;
  late Animation animationColor3;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    controller2 =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animationColor = ColorTween(begin: Colors.white, end: AppColor.glass)
        .animate(controller);
    animationColor2 =
        ColorTween(begin: const Color(0XFF8077E4), end: AppColor.white100)
            .animate(controller);
    animationColor3 =
        ColorTween(begin: const Color(0XFF8077E4), end: Color(0xFFF1B488))
            .animate(controller2);
    controller2.forward();
    controller2.addListener(() {});
    animationColor3.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });

    controller.forward();
    controller.addListener(() {});

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final duration = Duration(seconds: 5);
        sleep(duration);
        Navigator.pushNamed(context, FirstPage.rootName);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [animationColor3.value, Color(0xFF8077E4)],
                  begin: Alignment.bottomCenter),
              color: Colors.cyan,
            ),
          ),
          Center(
            child: Container(
              child: Center(
                child: Text(
                  'MemoryBox',
                  style: TextStyle(
                      color: animationColor2.value,
                      fontSize: controller.value * 45,
                      fontWeight: FontWeight.w700),
                ),
              ),
              height: 60.0,
              width: 250.0,
              decoration: BoxDecoration(
                color: animationColor.value,
                borderRadius: const BorderRadius.all(
                  Radius.circular(50.0),
                ),
              ),
            ),
          ),
          Positioned(
            top: 400,
            left: 130,
            child: Image.asset(
              'assets/images/microfon.png',
              width: 100,
              height: 100,
            ),
          )
        ],
      ),
    );
  }
}
