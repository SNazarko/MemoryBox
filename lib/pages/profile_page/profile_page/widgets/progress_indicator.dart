import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({Key? key}) : super(key: key);
  final int value = 150;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(50.0),
              ),
              border: Border.all(color: AppColor.colorText, width: 2.0)),
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          width: screenWidth * 0.75,
          height: 30.0,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(50.0),
            ),
            child: LinearProgressIndicator(
              value: value / 500,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColor.yellow100,
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ),
        Text('$value/500 мб')
      ],
    );
  }
}
