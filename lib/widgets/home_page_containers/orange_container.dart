import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class OrangeContainer extends StatelessWidget {
  const OrangeContainer({Key? key, required this.screenWidth})
      : super(key: key);
  final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text(
          'Tут',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      width: screenWidth / 2.3,
      height: 95.0,
      decoration: const BoxDecoration(
          color: AppColor.yellow100,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          )),
    );
  }
}
