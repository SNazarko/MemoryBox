import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/screens/screens_element/appbar_menu.dart';
import 'package:memory_box/screens/screens_element/bottom_nav_bar.dart';

import '../constants.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              AppbarMenu(),
              Positioned(
                left: 5,
                top: 120,
                child: Container(
                  height: 600,
                  width: 350,
                  decoration: kBorderContainer2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset('images/rec_upload.png'),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                    'images/rec_paper_download.png'),
                                padding: EdgeInsets.symmetric(horizontal: 15)),
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset('images/rec_delete.png'),
                                padding: EdgeInsets.symmetric(horizontal: 15)),
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Сохранить',
                                    style: TextStyle(fontSize: 16),
                                  )),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Text(
                        'Аудиозапись 1',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(
                        height: 220,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.replay_10)),
                          IconButton(
                              splashRadius: 110,
                              iconSize: 100,
                              onPressed: () {},
                              icon: Image.asset(
                                'images/play.png',
                              )),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.forward_10)),
                        ],
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
