import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/screens/screens_element/appbar_clipper.dart';
import 'package:memory_box/screens/screens_element/bottom_nav_bar.dart';
import 'package:memory_box/screens/screens_element/player_big.dart';

import '../resources/constants.dart';

class SavePage extends StatelessWidget {
  const SavePage({Key? key}) : super(key: key);
  final String titlePodborki = 'Название подборки';
  final String titleAudio = 'Название аудиозаписи';

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Container(
                height: screenHeight * 0.905,
              ),
              ClipPath(
                clipper: AppbarClipper(),
                child: Container(
                  color: kColorAppbar,
                  width: double.infinity,
                  height: 250,
                ),
              ),
              Positioned(
                left: 5,
                top: 40,
                child: Container(
                  height: 900,
                  width: screenWidth * 0.97,
                  decoration: kBorderContainer2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.check_circle_outline),
                            IconButton(
                                iconSize: 30,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.more_horiz,
                                  color: Color(0XFF3A3A55),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.4,
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      Text(
                        titlePodborki,
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(titleAudio, style: const TextStyle(fontSize: 14)),
                      SizedBox(
                        height: 30,
                      ),
                      PlayerBig(
                        playStopFunction: () {},
                        playStopIcon: const Icon(Icons.play_circle_filled),
                        replayFunction: () {},
                        forwardFunction: () {},
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          BottomNavBar(),
        ],
      ),
    );
  }
}
