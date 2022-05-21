import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_icons.dart';

class IconCamera extends StatelessWidget {
  const IconCamera({
    Key? key,
    required this.onTap,
    required this.color,
    required this.colorBorder,
    required this.position,
  }) : super(key: key);
  final void Function()? onTap;
  final Color color;
  final Color colorBorder;
  final double position;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Image.asset(
                AppIcons.camera,
                color: colorBorder,
              )),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: position,
          ),
          child: Center(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colorBorder,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
