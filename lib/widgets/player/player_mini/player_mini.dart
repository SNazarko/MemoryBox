import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:memory_box/resources/app_icons.dart';

import '../../uncategorized/slider.dart';

class PlayerMini extends StatefulWidget {
  const PlayerMini({
    Key? key,
    required this.url,
    required this.name,
    required this.duration,
    required this.popupMenu,
    required this.done,
    required this.id,
    required this.collection,
    this.playPause,
  }) : super(key: key);
  final String url;
  final String name;
  final String duration;
  final Widget popupMenu;
  final bool done;
  final bool? playPause;
  final String id;
  final List collection;

  @override
  State<PlayerMini> createState() => PlayerMiniState();
}

class PlayerMiniState extends State<PlayerMini> {
  late StreamSubscription<ap.PlayerState> _playerStateChangedSubscription;
  final player = ap.AudioPlayer();
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;
  bool _isPlay = false;
  bool _isPaused = false;
  bool _isReverse = false;
  Timer? _timer;
  int _recordDuration = 0;

  @override
  void initState() {
    _playerStateChangedSubscription =
        player.playerStateStream.listen((state) async {
      if (state.processingState == ap.ProcessingState.completed) {
        await stop();
      }
      setState(() {});
    });
    _positionChangedSubscription =
        player.positionStream.listen((position) => setState(() {}));
    _durationChangedSubscription =
        player.durationStream.listen((duration) => setState(() {}));
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _playerStateChangedSubscription.cancel();
    _positionChangedSubscription.cancel();
    _durationChangedSubscription.cancel();
    player.dispose();
    super.dispose();
  }

  void _init() async {
    bool _isPlay = false;
    await player.setUrl(widget.url);
    await player.setLoopMode(LoopMode.one);
  }

  Future<void> play() {
    setState(() => _isPlay = true);
    setState(() => _isReverse = true);
    _startTimer();

    return player.play();
  }

  Future<void> pause() {
    setState(() => _isPaused = true);
    _timer?.cancel();
    setState(() => _isReverse = false);
    return player.pause();
  }

  Future<void> stop() async {
    await player.stop();
    _timer?.cancel();
    setState(() => _recordDuration = 0);
    return player.seek(const Duration(milliseconds: 0));
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  Widget _buildText() {
    if (_isPlay || _isPaused) {
      return _buildTimer();
    }

    return const Text(
      '00:00',
      style: TextStyle(
          fontFamily: 'TTNorms',
          fontSize: 10.0,
          color: AppColor.colorText80,
          fontWeight: FontWeight.w400),
    );
  }

  Widget _buildTimer() {
    final durationAudioPlayer = player.duration;
    final durationMilliseconds = durationAudioPlayer?.inMilliseconds ?? 0;
    final durationDouble = durationMilliseconds / 1000;
    final duration = durationDouble.toInt();
    if (_recordDuration >= duration) {
      _recordDuration = 0;
    }
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);
    return Text(
      '$minutes : $seconds',
      style: const TextStyle(
          fontFamily: 'TTNorms',
          fontSize: 10.0,
          color: AppColor.colorText80,
          fontWeight: FontWeight.w400),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  Widget _duration() {
    final durationAudioPlayer = player.duration;
    final durationMilliseconds = durationAudioPlayer?.inMilliseconds ?? 0;
    final durationDouble = durationMilliseconds / 1000;
    final duration = durationDouble.toInt();
    final String minutes = _formatNumber(duration ~/ 60);
    final String seconds = _formatNumber(duration % 60);
    return Text(
      '$minutes : $seconds',
      style: const TextStyle(
          fontFamily: 'TTNorms',
          fontSize: 10.0,
          color: AppColor.colorText80,
          fontWeight: FontWeight.w400),
    );
  }

  Widget _buildControl() {
    Widget icon;

    if (player.playerState.playing || widget.playPause == true) {
      icon = Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset(
          AppIcons.stop,
          fit: BoxFit.fill,
        ),
      );
    } else {
      icon = Image.asset(
        'assets/images/4x/play_aud.png',
        fit: BoxFit.fill,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ClipOval(
        child: Material(
          child: InkWell(
            child: SizedBox(width: 55, height: 55, child: icon),
            onTap: () {
              if (player.playerState.playing) {
                // AudioRepositories().playPause(
                //   widget.id,
                //   false,
                // );
                pause();
                setState(() {});
              } else {
                // AudioRepositories().playPause(
                //   widget.id,
                //   true,
                // );
                setState(() {});
                play();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSlider() {
    final position = player.position;
    final duration = player.duration;
    bool canSetValue = false;
    if (duration != null) {
      canSetValue = position.inMilliseconds > 0;
      canSetValue &= position.inMilliseconds < duration.inMilliseconds;
    }
    return SizedBox(
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
            thumbShape: const RoundedAmebaThumbShape(
                radius: 8, color: AppColor.colorText),
            thumbColor: AppColor.colorText,
            inactiveTrackColor: AppColor.colorText,
            activeTrackColor: AppColor.colorText),
        child: Slider(
          onChanged: (v) {
            if (duration != null) {
              final position = v * duration.inMilliseconds;
              player.seek(Duration(milliseconds: position.round()));
            }
          },
          value: canSetValue && duration != null
              ? position.inMilliseconds / duration.inMilliseconds
              : 0.0,
        ),
      ),
    );
  }

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
        height: 65.0,
        width: double.infinity,
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: SizedBox(
                child: _buildControl(),
              ),
            ),
            Flexible(
              flex: 10,
              child: _isReverse
                  ? SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  widget.name,
                                  style: const TextStyle(
                                      fontFamily: 'TTNorms',
                                      fontSize: 14.0,
                                      color: AppColor.colorText,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            Expanded(child: _buildSlider()),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [_buildText(), _duration()],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontFamily: 'TTNorms',
                                    fontSize: 14.0,
                                    color: AppColor.colorText,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '${widget.duration} минут',
                                style: const TextStyle(
                                    fontFamily: 'TTNorms',
                                    fontSize: 14.0,
                                    color: AppColor.colorText80,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(child: SizedBox())
                      ],
                    )),
            ),
            Flexible(
              flex: 3,
              child: widget.popupMenu,
            )
          ],
        ),
      ),
    );
  }
}
//Row(
//           children: [
//             _buildControl(),
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widgets.name,
//                     maxLines: 1,
//                     overflow: TextOverflow.fade,
//                     softWrap: true,
//                     style: const TextStyle(
//                       fontSize: 14.0,
//                     ),
//                   ),
//                   SizedBox(
//                     child: Column(
//                       children: [
//                         _buildSlider(),
//                         Padding(
//                           padding:
//                               const EdgeInsets.only(left: 15.0, right: 20.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [_buildText(), _duration()],
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                   // Text(
//                   //   '${widgets.duration} минут',
//                   //   style: const TextStyle(
//                   //     color: AppColor.colorText50,
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: SizedBox(),
//             ),
//             widgets.popupMenu
//           ],
//         ),
