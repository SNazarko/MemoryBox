import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/players/bloc/sound_bloc.dart';
import 'package:memory_box/players/save_audio.dart';
import 'package:memory_box/players/sound_record.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/screens/screens_element/appbar_menu.dart';
import 'package:memory_box/screens/screens_element/bottom_nav_bar.dart';
import 'package:memory_box/screens/screens_element/drawer_menu.dart';
import 'package:provider/src/provider.dart';

import '../resources/constants.dart';

class PlayPage extends StatefulWidget {
  PlayPage({Key? key}) : super(key: key);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  SoundRecording soundRecord = SoundRecording();
  TextEditingController _controller = TextEditingController(text: 'Аудиофайл');

  bool _isVisible = false;
  bool _play = false;
  String _recordtxt = '00:00:00';
  String _saveRecord = 'Аудио';
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  double height = 40;
  double _mSubscriptionDuration = 0;

  @override
  void initState() {
    soundRecord.initState(
        _mPlayerIsInited, _mRecorderIsInited, _mSubscriptionDuration);
    setState(() {
      _mPlayerIsInited = true;
      _mRecorderIsInited = true;
      _mSubscriptionDuration;
    });
    super.initState();
  }

  @override
  void dispose() {
    soundRecord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => IconPlayPauseBloc(),
        ),
        BlocProvider(
          create: (context) => IconRecPlayPauseBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        drawer: DrawerMenu(),
        bottomNavigationBar: BottomNavBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  AppbarMenu(),
                  Positioned(
                    left: 5.0,
                    top: 30.0,
                    child: Container(
                      height: 520.0,
                      width: screenWidth * 0.97,
                      decoration: kBorderContainer2,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Visibility(
                              visible: !_isVisible,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Отменить',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _isVisible,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Image.asset(AppIcons.rec_upload),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                          AppIcons.rec_paper_download),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(AppIcons.rec_delete),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 50.0),
                                    child: TextButton(
                                      onPressed: () {
                                        SaveAudio(_saveRecord).saveFile();

                                        // Navigator.pushNamed(
                                        //   context,
                                        //   '/SavePage',
                                        // );
                                      },
                                      child: const Text(
                                        'Сохранить',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Visibility(
                            visible: !_isVisible,
                            child: const Text(
                              'Запись',
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 60.0,
                          ),
                          Visibility(
                            visible: _isVisible,
                            child: SizedBox(
                              width: 200.0,
                              child: TextField(
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 24.0),
                                controller: _controller,
                                onChanged: (value) {
                                  _saveRecord = value;
                                },
                              ),
                            ),
                          ),
                          // TimerWidget(
                          //   timerController: TimerController(),
                          // ),
                          const SizedBox(
                            height: 70.0,
                          ),

                          Visibility(
                            visible: _isVisible,
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                  thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 7.0),
                                  thumbColor: const Color(0xFF3A3A55),
                                  activeTickMarkColor: const Color(0xFF3A3A55),
                                  inactiveTrackColor: const Color(0xFF3A3A55),
                                  inactiveTickMarkColor:
                                      const Color(0xFF3A3A55)),
                              child: Slider(
                                value: _mSubscriptionDuration,
                                min: 0.0,
                                max: 2000.0,
                                onChanged: soundRecord.setSubscriptionDuration,
                                //divisions: 100
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          Visibility(
                            visible: !_isVisible,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 10.0,
                                  height: 10.0,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE27777),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  soundRecord.playerTxt,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height,
                          ),
                          Visibility(
                            visible: _isVisible,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.replay_10,
                                  ),
                                ),
                                BlocBuilder<IconPlayPauseBloc, Icon>(
                                  builder: (context, stateIconPlayer) {
                                    return IconButton(
                                        iconSize: 100.0,
                                        onPressed: () {
                                          _play = !_play;
                                          if (_play) {
                                            context
                                                .read<IconPlayPauseBloc>()
                                                .add(PlayerPlay());
                                            soundRecord.play(_mPlayerIsInited,
                                                _mplaybackReady);
                                          }
                                          if (!_play) {
                                            context
                                                .read<IconPlayPauseBloc>()
                                                .add(PlayerStop());
                                            soundRecord.stopPlayer();
                                            // setState(() {});
                                          }
                                        },
                                        icon: stateIconPlayer);
                                  },
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.forward_10)),
                              ],
                            ),
                          ),
                          Visibility(
                              visible: !_isVisible,
                              child: BlocBuilder<IconRecPlayPauseBloc, Icon>(
                                builder: (context, stateIconPlayer) {
                                  return IconButton(
                                      iconSize: 100.0,
                                      onPressed: () async {
                                        _play = !_play;
                                        if (_play) {
                                          context
                                              .read<IconRecPlayPauseBloc>()
                                              .add(RecordPlay());
                                          soundRecord.record();
                                        }
                                        if (!_play) {
                                          context
                                              .read<IconRecPlayPauseBloc>()
                                              .add(RecordStop());
                                          soundRecord
                                              .stopRecorder(_mplaybackReady);
                                          setState(() {
                                            _isVisible = !_isVisible;
                                            height = 0.0;
                                          });
                                          _mplaybackReady = true;
                                        }
                                      },
                                      icon: stateIconPlayer);
                                },
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}