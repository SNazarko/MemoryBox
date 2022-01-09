import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';

class ButtonContinue extends StatelessWidget {
  const ButtonContinue({Key? key, this.onPressed}) : super(key: key);
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text(
        'Продолжить',
        style: TextStyle(fontSize: 18.0),
      ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size(275.0, 50.0),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          const Color(ColorApp.yellow100),
        ),
      ),
    );
  }
}
