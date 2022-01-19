import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/bottom_nav_bar.dart';
import 'package:memory_box/widgets/player_big.dart';

import '../resources/constants.dart';

class SavePage extends StatelessWidget {
  const SavePage({Key? key}) : super(key: key);
  static const rootName = '/save_page';
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
                  color: AppColor.colorAppbar,
                  width: double.infinity,
                  height: 250.0,
                ),
              ),
              Positioned(
                left: 5.0,
                top: 40.0,
                child: Container(
                  height: 900.0,
                  width: screenWidth * 0.97,
                  decoration: kBorderContainer2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.check_circle_outline),
                            IconButton(
                                iconSize: 30.0,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.more_horiz,
                                  color: AppColor.colorText,
                                ))
                          ],
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.4,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                      ),
                      Text(
                        titlePodborki,
                        style: const TextStyle(fontSize: 24.0),
                      ),
                      Text(
                        titleAudio,
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 30.0,
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
