import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';

class PlayerMini extends StatelessWidget {
  const PlayerMini({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 10.0,
        bottom: 10.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        height: 75.0,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              width: 70.0,
              height: 70.0,
              child: Image.asset(
                'assets/images/4x/play_aud.png',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Малышь Кокки 1',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    '30 минут',
                    style: TextStyle(
                      color: Color(ColorApp.colorText),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  size: 30.0,
                ))
          ],
        ),
      ),
    );
  }
}
