import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonContinue extends StatelessWidget {
  const ButtonContinue({Key? key, this.onPressed}) : super(key: key);
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text(
        'Продолжить',
        style: TextStyle(fontSize: 18),
      ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(275, 50)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        backgroundColor: MaterialStateProperty.all(const Color(0xFFF1B488)),
      ),
    );
  }
}
