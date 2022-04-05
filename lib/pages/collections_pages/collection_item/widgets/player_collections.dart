import 'dart:async';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import '../../../../resources/app_colors.dart';
import '../../../../widgets/slider.dart';
import '../collections_item_page_model.dart';

class PlayerCollections extends StatefulWidget {
  const PlayerCollections({
    Key? key,
    required this.screenHeight,
    required this.screenWight,
  }) : super(key: key);
  final double screenHeight;
  final double screenWight;

  @override
  State<PlayerCollections> createState() => _PlayerCollectionsState();
}

class _PlayerCollectionsState extends State<PlayerCollections> {
  final _audioPlayer = ap.AudioPlayer();
  late StreamSubscription<ap.PlayerState> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;
  bool _isPlay = false;
  bool _isPaused = false;
  Timer? _timer;
  Timer? _ampTimer;
  Amplitude? _amplitude;
  int _recordDuration = 0;
  late final String url;

  @override
  void initState() {
    _playerStateChangedSubscription =
        _audioPlayer.playerStateStream.listen((state) async {
      if (state.processingState == ap.ProcessingState.completed) {
        await stop();
      }
      setState(() {});
    });
    _positionChangedSubscription =
        _audioPlayer.positionStream.listen((position) => setState(() {}));
    _durationChangedSubscription =
        _audioPlayer.durationStream.listen((duration) => setState(() {}));
    _init();

    super.initState();
  }

  Future<void> _init() async {
    bool _isPlay = false;
    await _audioPlayer.setUrl(url);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _playerStateChangedSubscription.cancel();
    _positionChangedSubscription.cancel();
    _durationChangedSubscription.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  Widget _buildControl() {
    Widget icon;

    if (_audioPlayer.playerState.playing) {
      icon = Padding(
        padding: const EdgeInsets.all(1.0),
        child: Image.asset(
          AppIcons.pause_white,
          fit: BoxFit.fill,
        ),
      );
    } else {
      icon = Image.asset(
        AppIcons.play_white,
        fit: BoxFit.fill,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipOval(
        child: Material(
          child: InkWell(
            child: Container(
              width: context.watch<CollectionsItemPageModel>().getAnim * 55.0,
              height: context.watch<CollectionsItemPageModel>().getAnim * 55.0,
              child: icon,
              color: const Color(0xFF8C84E2),
            ),
            onTap: () {
              if (_audioPlayer.playerState.playing) {
                pause();
                setState(() {});
              } else {
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
    final position = _audioPlayer.position;
    final duration = _audioPlayer.duration;
    bool canSetValue = false;
    if (duration != null) {
      canSetValue = position.inMilliseconds > 0;
      canSetValue &= position.inMilliseconds < duration.inMilliseconds;
    }

    return SizedBox(
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
            thumbShape:
                const RoundedAmebaThumbShape(radius: 8, color: AppColor.white),
            thumbColor: AppColor.white,
            inactiveTrackColor: AppColor.white,
            activeTrackColor: AppColor.white),
        child: Slider(
          onChanged: (v) {
            if (duration != null) {
              final position = v * duration.inMilliseconds;
              _audioPlayer.seek(Duration(milliseconds: position.round()));
            }
          },
          value: canSetValue && duration != null
              ? position.inMilliseconds / duration.inMilliseconds
              : 0.0,
        ),
      ),
    );
  }

  // Future<void> loop() {
  //   setState(() => _isPlay = true);
  //   _startTimer();
  //   return _audioPlayer.;
  // }

  Future<void> play() {
    setState(() => _isPlay = true);
    _startTimer();
    return _audioPlayer.play();
  }

  Future<void> pause() {
    setState(() => _isPaused = true);
    _timer?.cancel();
    return _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _timer?.cancel();
    setState(() => _recordDuration = 0);
    return _audioPlayer.seek(const Duration(milliseconds: 0));
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

    return Text('00:00');
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);
    return Text(
      '$minutes : $seconds',
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.screenHeight * 0.9,
      width: widget.screenWight,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Visibility(
            visible: true,
            child: Container(
                width: double.infinity,
                height:
                    context.watch<CollectionsItemPageModel>().getAnim * 75.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF8C84E2).withOpacity(
                          context.watch<CollectionsItemPageModel>().getAnim),
                      const Color(0xFF6C689F).withOpacity(
                          context.watch<CollectionsItemPageModel>().getAnim),
                    ],
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                ),
                child: Row(
                  children: [
                    Flexible(
                        flex: 3,
                        child: SizedBox(
                          child: _buildControl(),
                        )),
                    Flexible(
                        flex: 10,
                        child: SizedBox(
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
                                      'Малышь Кокки 1',
                                      style: TextStyle(
                                          fontFamily: 'TTNorms',
                                          fontSize: context
                                                  .watch<
                                                      CollectionsItemPageModel>()
                                                  .getAnim *
                                              14.0,
                                          color: Colors.white,
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
                                      children: [
                                        Text(
                                          '00:00',
                                          style: TextStyle(
                                              fontFamily: 'TTNorms',
                                              fontSize: context
                                                      .watch<
                                                          CollectionsItemPageModel>()
                                                      .getAnim *
                                                  10.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          '00:00',
                                          style: TextStyle(
                                              fontFamily: 'TTNorms',
                                              fontSize: context
                                                      .watch<
                                                          CollectionsItemPageModel>()
                                                      .getAnim *
                                                  10.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            AppIcons.next,
                            width: context
                                    .watch<CollectionsItemPageModel>()
                                    .getAnim *
                                24.0,
                            height: context
                                    .watch<CollectionsItemPageModel>()
                                    .getAnim *
                                24.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(12.0),
                //       child: SizedBox(
                //         width: context.watch<CollectionsItemPageModel>().getAnim *
                //             50.0,
                //         height:
                //             context.watch<CollectionsItemPageModel>().getAnim *
                //                 50.0,
                //         child: _buildControl(),
                //       ),
                //     ),
                //     Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'Малышь Кокки 1',
                //           style: TextStyle(
                //               fontFamily: 'TTNorms',
                //               fontSize: context
                //                       .watch<CollectionsItemPageModel>()
                //                       .getAnim *
                //                   14.0,
                //               color: Colors.white,
                //               fontWeight: FontWeight.w400),
                //         ),
                //         _buildSlider(widget.screenWight),
                //         // Text(
                //         //   '----------------------------------',
                //         //   style: TextStyle(
                //         //       fontFamily: 'TTNorms',
                //         //       fontSize: context
                //         //               .watch<CollectionsItemPageModel>()
                //         //               .getAnim *
                //         //           14.0,
                //         //       color: Colors.white,
                //         //       fontWeight: FontWeight.w400),
                //         // ),
                //         // Row(
                //         //   children: [
                //         //     Text(
                //         //       '00:00',
                //         //       style: TextStyle(
                //         //           fontFamily: 'TTNorms',
                //         //           fontSize: context
                //         //                   .watch<CollectionsItemPageModel>()
                //         //                   .getAnim *
                //         //               10.0,
                //         //           color: Colors.white,
                //         //           fontWeight: FontWeight.w400),
                //         //     ),
                //         //     SizedBox(
                //         //       width: context
                //         //               .watch<CollectionsItemPageModel>()
                //         //               .getAnim *
                //         //           140.0,
                //         //     ),
                //         //     Text(
                //         //       '00:00',
                //         //       style: TextStyle(
                //         //           fontFamily: 'TTNorms',
                //         //           fontSize: context
                //         //                   .watch<CollectionsItemPageModel>()
                //         //                   .getAnim *
                //         //               10.0,
                //         //           color: Colors.white,
                //         //           fontWeight: FontWeight.w400),
                //         //     ),
                //         //   ],
                //         // ),
                //       ],
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(right: 30.0),
                //       child: GestureDetector(
                //         onTap: () {},
                //         child: Image.asset(
                //           AppIcons.next,
                //           width:
                //               context.watch<CollectionsItemPageModel>().getAnim *
                //                   24.0,
                //           height:
                //               context.watch<CollectionsItemPageModel>().getAnim *
                //                   24.0,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                ),
          ),
        ),
      ),
    );
  }
}
