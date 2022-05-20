import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:memory_box/resources/app_icons.dart';

import '../../../repositories/audio_repositories.dart';
import '../../../repositories/auth_repositories.dart';
import '../../../resources/app_colors.dart';
import '../../uncategorized/slider.dart';

class PlayerCollections extends StatefulWidget {
  const PlayerCollections({
    Key? key,
    required this.screenHeight,
    required this.screenWight,
    required this.idCollection,
    required this.animation,
  }) : super(key: key);
  final double screenHeight;
  final double screenWight;
  final String idCollection;
  final double animation;

  @override
  State<PlayerCollections> createState() => PlayerCollectionsState();
}

class PlayerCollectionsState extends State<PlayerCollections> {
  final _audioPlayer = ap.AudioPlayer();
  late StreamSubscription<ap.PlayerState> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;
  bool _isPlay = false;
  bool _isPaused = false;
  Timer? _timer;
  int _recordDuration = 0;
  List<String> audioNameList = [];
  List<String> audioIdList = [];
  int initialIndex = 0;

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
    player();
    _init();

    super.initState();
  }

  Future<void> _init() async {
    bool _isPlay = false;
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
              width: widget.animation * 55.0,
              height: widget.animation * 55.0,
              child: icon,
              color: const Color(0xFF8C84E2),
            ),
            onTap: () {
              final index = _audioPlayer.currentIndex;
              if (_audioPlayer.playerState.playing) {
                pause();
                AudioRepositories.instance.playPause(
                  audioIdList[index!.toInt()],
                  false,
                );
                setState(() {});
              } else {
                setState(() {});
                play();
                AudioRepositories.instance.playPause(
                  audioIdList[index!.toInt()],
                  true,
                );
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
          thumbShape: RoundedAmebaThumbShape(
            radius: 8,
            color:
                widget.animation <= 0.3 ? Colors.transparent : AppColor.white,
          ),
          thumbColor:
              widget.animation <= 0.3 ? Colors.transparent : AppColor.white,
          inactiveTrackColor:
              widget.animation <= 0.3 ? Colors.transparent : AppColor.white,
          activeTrackColor:
              widget.animation <= 0.3 ? Colors.transparent : AppColor.white,
        ),
        child: Slider(
          onChanged: (v) {
            if (duration != null) {
              final position = v * duration.inMilliseconds;
              _audioPlayer.seek(
                Duration(
                  milliseconds: position.round(),
                ),
              );
            }
          },
          value: canSetValue && duration != null
              ? position.inMilliseconds / duration.inMilliseconds
              : 0.0,
        ),
      ),
    );
  }

  Future<void> player() async {
    List<AudioSource> audioUrlList = [];
    if (AuthRepositories.instance.user != null) {
      await FirebaseFirestore.instance
          .collection(AuthRepositories.instance.user!.phoneNumber!)
          .doc('id')
          .collection('Collections')
          .where('collections', arrayContains: widget.idCollection)
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          final String audioUrl = result.data()['audioUrl'];
          final String audioName = result.data()['audioName'];
          final String audioId = result.data()['id'];
          audioUrlList.add(AudioSource.uri(Uri.parse(audioUrl)));
          audioNameList.add(audioName);
          audioIdList.add(audioId);
        }
      });

      await _audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
          useLazyPreparation: true, // default
          shuffleOrder: DefaultShuffleOrder(), // default
          children: audioUrlList,
        ),
        initialIndex: initialIndex, // default
        initialPosition: Duration.zero, // default
      );
    }
  }

  Future<void> seekToNext() {
    _recordDuration = 0;
    return _audioPlayer.seekToNext();
  }

  Future<void> play() {
    setState(() => _isPlay = true);
    startTimer();
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

  void startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  Widget _buildText() {
    if (_isPlay || _isPaused) {
      return _buildTimer();
    }

    return Text(
      '00:00',
      style: TextStyle(
          fontFamily: 'TTNorms',
          fontSize: widget.animation * 10.0,
          color: Colors.white,
          fontWeight: FontWeight.w400),
    );
  }

  Widget _buildTimer() {
    final index = _audioPlayer.currentIndex;
    final durationAudioPlayer = _audioPlayer.duration;
    final durationMilliseconds = durationAudioPlayer?.inMilliseconds ?? 0;
    final position = _audioPlayer.position;
    if (position.inMilliseconds / durationMilliseconds * 100 >= 0.1) {
      if (position.inMilliseconds / durationMilliseconds * 100 <= 2) {
        AudioRepositories.instance.playPause(
          audioIdList[index!.toInt()],
          true,
        );
      }
    }

    if (position.inMilliseconds / durationMilliseconds * 100 >= 98) {
      AudioRepositories.instance.playPause(
        audioIdList[index!.toInt()],
        false,
      );
      _recordDuration = 0;
    }

    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);
    return Text(
      '$minutes : $seconds',
      style: TextStyle(
          fontFamily: 'TTNorms',
          fontSize: widget.animation * 10.0,
          color: Colors.white,
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
    final durationAudioPlayer = _audioPlayer.duration;
    final durationMilliseconds = durationAudioPlayer?.inMilliseconds ?? 0;
    final durationDouble = durationMilliseconds / 1000;
    final duration = durationDouble.toInt();
    final String minutes = _formatNumber(duration ~/ 60);
    final String seconds = _formatNumber(duration % 60);
    return Text(
      '$minutes : $seconds',
      style: TextStyle(
          fontFamily: 'TTNorms',
          fontSize: widget.animation * 10.0,
          color: Colors.white,
          fontWeight: FontWeight.w400),
    );
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
                height: widget.animation * 75.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF8C84E2).withOpacity(widget.animation),
                      const Color(0xFF6C689F).withOpacity(widget.animation),
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
                                      title(),
                                      style: TextStyle(
                                          fontFamily: 'TTNorms',
                                          fontSize: widget.animation * 14.0,
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
                                      children: [_buildText(), _duration()],
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
                          onTap: () {
                            if (_audioPlayer.nextIndex != null) {
                              AudioRepositories.instance.playPause(
                                audioIdList[_audioPlayer.currentIndex!.toInt()],
                                false,
                              );
                              seekToNext();
                            } else {
                              AudioRepositories.instance.playPause(
                                audioIdList[_audioPlayer.currentIndex!.toInt()],
                                false,
                              );
                              player();
                            }
                          },
                          child: Image.asset(
                            AppIcons.next,
                            width: widget.animation * 24.0,
                            height: widget.animation * 24.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  String title() {
    final index = _audioPlayer.currentIndex;
    final String title = audioNameList.isNotEmpty ? audioNameList[index!] : '';
    return title;
  }
}
