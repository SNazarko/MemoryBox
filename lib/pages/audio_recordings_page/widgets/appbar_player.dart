import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';

class AppbarPlayer extends StatelessWidget {
  const AppbarPlayer({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 46.0,
            width: 200.0,
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: Image.asset(
                    AppIcons.vector,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 1.0, top: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: Image.asset(
                      AppIcons.play_aud,
                    ),
                  ),
                  const Text(
                    'Запустить все',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColor.blue100,
                    ),
                  ),
                ],
              ),
            ),
            height: 46.0,
            width: 150.0,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                )),
          ),
        ),
      ],
    );
  }
}
