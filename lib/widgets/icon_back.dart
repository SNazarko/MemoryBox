import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconBack extends StatelessWidget {
  const IconBack({Key? key, this.onPressed}) : super(key: key);
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30.0,
        left: 15.0,
        right: 10.0,
      ),
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
                width: 30.0,
                height: 30.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: IconButton(
                iconSize: 30.0,
                color: Colors.white,
                onPressed: onPressed,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
