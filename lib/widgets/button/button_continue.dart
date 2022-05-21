import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';

class ButtonContinue extends StatelessWidget {
  const ButtonContinue({Key? key, this.onPressed, required this.text})
      : super(key: key);
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18.0,
          color: AppColor.white100,
        ),
      ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size(
            275.0,
            50.0,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          AppColor.yellow100,
        ),
      ),
    );
  }
}
