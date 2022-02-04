import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import '../../resources/constants.dart';
import 'appbar_clipper.dart';

class AppbarMenu extends StatelessWidget {
  const AppbarMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Stack(children: [
        Container(
          height: screenHeight / 1.27,
        ),
        ClipPath(
          clipper: AppbarClipper(),
          child: Container(
            color: AppColor.colorAppbar,
            width: double.infinity,
            height: 280.0,
          ),
        ),
      ]),
    );
  }
}
