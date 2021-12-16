import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'appbar_clipper.dart';

class AppbarMenu extends StatelessWidget {
  const AppbarMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Stack(children: [
        Container(
          height: screenHeight / 1.1038,
        ),
        ClipPath(
          clipper: AppbarClipper(),
          child: Container(
            color: kColorAppbar,
            width: double.infinity,
            height: 250,
          ),
        ),
        Positioned(
          left: 0,
          top: 30,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ),
      ]),
    );
  }
}
