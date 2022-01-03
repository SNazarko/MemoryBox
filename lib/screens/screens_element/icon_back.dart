import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconBack extends StatelessWidget {
  const IconBack({Key? key, this.onPressed}) : super(key: key);
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 15, right: 10),
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Stack(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                width: 30,
                height: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: IconButton(
                iconSize: 30,
                color: Colors.white,
                onPressed: onPressed,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
