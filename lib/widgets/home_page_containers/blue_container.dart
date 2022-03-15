import 'package:flutter/material.dart';
import '../../resources/app_colors.dart';

class BlueContainer extends StatelessWidget {
  const BlueContainer({Key? key, required this.screenWidth}) : super(key: key);
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text(
          'И тут',
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
          color: AppColor.blue200,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          )),
    );
  }
}
