import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/players/bloc/sound_bloc.dart';
import 'package:memory_box/players/sound_record.dart';
import 'package:memory_box/screens/screens_element/appbar_menu.dart';
import 'package:memory_box/screens/screens_element/bottom_nav_bar.dart';
import 'package:provider/src/provider.dart';

import '../constants.dart';

class PlayPage extends StatefulWidget {
  PlayPage({Key? key}) : super(key: key);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  SoundRecord soundRecord = SoundRecord();
  bool _isVisible = false;
  bool _play = false;
  String _recordtxt = '00:00:00';
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
                                  vertical: 10, horizontal: 20),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Отменить',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _isVisible,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset('images/rec_upload.png'),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Image.asset(
                                        'images/rec_paper_download.png'),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Image.asset('images/rec_delete.png'),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15)),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/SavePage',
                                      );
                                    },
                                    child: const Text(
                                      'Сохранить',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible: !_isVisible,
                          child: const Text(
                            'Запись',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Visibility(
                          visible: _isVisible,
                          child: const Text(
                            'Аудиозапись 1',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                        // TimerWidget(
                        //   timerController: TimerController(),
                        // ),
                        const SizedBox(
                          height: 70,
                        ),

                        Visibility(
                          visible: _isVisible,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 7),
                                thumbColor: const Color(0xFF3A3A55),
                                activeTickMarkColor: const Color(0xFF3A3A55),
                                inactiveTrackColor: const Color(0xFF3A3A55),
                                inactiveTickMarkColor: const Color(0xFF3A3A55)),
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
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE27777),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                _recordtxt,
                                style: const TextStyle(
                                  fontSize: 18,
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
                                      iconSize: 100,
                                      onPressed: () {
                                        setState(() {
                                          _play = !_play;
                                        });
                                        if (_play) {
                                          context
                                              .read<IconPlayPauseBloc>()
                                              .add(PlayerPlay());
                                          soundRecord.play(_mPlayerIsInited,
                                              _mplaybackReady);
                                          setState(() {});
                                        }
                                        if (!_play) {
                                          context
                                              .read<IconPlayPauseBloc>()
                                              .add(PlayerStop());
                                          soundRecord.stopPlayer();
                                          setState(() {});
                                        }
                                      },
                                      icon: stateIconPlayer

                                      // _play
                                      //     ? const Icon(Icons.pause_circle_filled)
                                      //     : const Icon(Icons.play_circle_filled),
                                      );
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
                                    iconSize: 100,
                                    onPressed: () async {
                                      setState(() {
                                        // recPlayStop.add(RecordPlayStop());
                                        _play = !_play;
                                        if (_play) {
                                          context
                                              .read<IconRecPlayPauseBloc>()
                                              .add(RecordPlay());
                                          setState(() {
                                            soundRecord.record();
                                          });
                                        }
                                        if (!_play) {
                                          context
                                              .read<IconRecPlayPauseBloc>()
                                              .add(RecordStop());
                                          soundRecord
                                              .stopRecorder(_mplaybackReady);
                                          setState(() {
                                            _isVisible = !_isVisible;
                                            height = 15;
                                            _mplaybackReady = true;
                                          });
                                        }
                                      });
                                    },
                                    icon: stateIconPlayer);
                                // _play
                                //     ? const Icon(Icons.play_circle_filled)
                                //     : const Icon(Icons.mic_none));
                              },
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
            BottomNavBar(),
          ],
        ),
      ),
    );
  }
}
