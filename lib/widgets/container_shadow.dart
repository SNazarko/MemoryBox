import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/constants.dart';

class ContainerShadow extends StatelessWidget {
  const ContainerShadow(
      {Key? key,
      required this.width,
      required this.height,
      required this.widget,
      required this.radius})
      : super(key: key);
  final double radius;
  final double width;
  final double height;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0.0, 5.0),
              blurRadius: 5.0,
            )
          ]),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: widget,
          ),
        ),
      ),
    );
  }
}
