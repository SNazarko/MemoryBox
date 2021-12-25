import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/screens/screens_element/appbar_clipper.dart';
import 'package:memory_box/screens/screens_element/appbar_menu.dart';
import 'package:memory_box/screens/screens_element/bottom_nav_bar.dart';

import '../constants.dart';

class AudioRecordingsPage extends StatelessWidget {
  const AudioRecordingsPage({Key? key}) : super(key: key);
  final int qualityAudio = 20;
  final String time = '10:30';

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
              Container(),
              ClipPath(
                clipper: AppbarClipper(),
                child: Container(
                  color: kColorAppbar,
                  width: double.infinity,
                  height: 210,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      iconSize: 30,
                      color: Colors.white,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                      ),
                    ),
                    const Text(
                      'Аудиозаписи',
                      style: kTitleTextStyle2,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_horiz),
                      color: Colors.white,
                      iconSize: 30,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 70,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Все в одном месте',
                      style: kTitle2TextStyle2,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 105,
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$qualityAudio аудио',
                          style: kTitle2TextStyle2,
                        ),
                        Text(
                          '$time часов',
                          style: kTitle2TextStyle2,
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 46,
                          width: 200,
                          decoration: const BoxDecoration(
                              color: Color(0xFFF6F6F6),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 40,
                                height: 40,
                                child: Image.asset(
                                  'images/vector.png',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(right: 5, top: 13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'images/play_aud.png',
                                  width: 50,
                                  height: 50,
                                ),
                                const Text(
                                  'Запустить все',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF8C84E2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          height: 46,
                          width: 150,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Container(),
          BottomNavBar(),
        ],
      ),
    );
  }
}
