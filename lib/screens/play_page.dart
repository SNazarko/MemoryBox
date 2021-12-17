import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/players/sound_record.dart';
import 'package:memory_box/screens/screens_element/appbar_menu.dart';
import 'package:memory_box/screens/screens_element/bottom_nav_bar.dart';

import '../constants.dart';

class PlayPage extends StatefulWidget {
  PlayPage({Key? key}) : super(key: key);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final recorder = SoundRecord();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recorder.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    recorder.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRecording = recorder.isRecording;
    final icon = isRecording ? 'stop' : 'play';
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
                        height: 200,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.replay_10)),
                          IconButton(
                              splashRadius: 110,
                              iconSize: 100,
                              onPressed: () async {
                                final isRecording =
                                    await recorder.toggleRecorder();
                                setState(() {});
                              },
                              icon: Image.asset(
                                'images/$icon.png',
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
