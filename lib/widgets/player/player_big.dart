import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:memory_box/widgets/uncategorized/slider.dart';
import 'package:record/record.dart';

class PlayerBig extends StatefulWidget {
  const PlayerBig({Key? key, this.url, this.duration}) : super(key: key);
  final String? url;
  final String? duration;

  @override
  State<PlayerBig> createState() => _PlayerBigState();
}

class _PlayerBigState extends State<PlayerBig> {
  static const double _controlSize = 56;
  static const double _deleteBtnSize = 24;

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
    await _audioPlayer.setUrl(widget.url!);
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            _buildSlider(constraints.maxWidth),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildText(),
                  Text(widget.duration!),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () async {
                    await _audioPlayer.seek(
                      Duration(seconds: _audioPlayer.position.inSeconds - 15),
                    );
                    _recordDuration - 15;
                  },
                  icon: const Icon(
                    Icons.replay_10,
                  ),
                ),
                _buildControl(),
                IconButton(
                  onPressed: () async {
                    await _audioPlayer.seek(
                      Duration(seconds: _audioPlayer.position.inSeconds + 15),
                    );
                    _recordDuration + 15;
                  },
                  icon: const Icon(
                    Icons.forward_10,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildControl() {
    Widget icon;

    if (_audioPlayer.playerState.playing) {
      icon = Image.asset(
        AppIcons.stop,
        fit: BoxFit.fill,
      );
    } else {
      icon = Image.asset(
        AppIcons.play,
        fit: BoxFit.fill,
      );
    }

    return ClipOval(
      child: Material(
        child: InkWell(
          child: SizedBox(width: 80, height: 80, child: icon),
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
    );
  }

  Widget _buildSlider(double widgetWidth) {
    final position = _audioPlayer.position;
    final duration = _audioPlayer.duration;
    bool canSetValue = false;
    if (duration != null) {
      canSetValue = position.inMilliseconds > 0;
      canSetValue &= position.inMilliseconds < duration.inMilliseconds;
    }

    double width = widgetWidth - _controlSize - _deleteBtnSize;
    width -= _deleteBtnSize;

    return SizedBox(
      width: width * 2,
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
}
