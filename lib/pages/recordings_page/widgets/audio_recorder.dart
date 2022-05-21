import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/app_icons.dart';
import '../../../utils/constants.dart';
import '../../../widgets/button/alert_dialog.dart';
import '../bloc/recordings_page/recordings_page_bloc.dart';

class AudioRecorder extends StatefulWidget {
  final void Function(String path) onStop;
  const AudioRecorder({required this.onStop});

  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  bool _isRecording = false;
  bool _isPaused = false;
  int _recordDuration = 0;
  double _incWidth = 0;
  Timer? _timer;
  Timer? _ampTimer;
  Timer? _timerAmplitude;
  final _audioRecorder = Record();
  Amplitude? _amplitude;
  double _dcb = 0;
  final List _listAmplitude = [];
  final ScrollController? _scrollController = ScrollController();

  @override
  void initState() {
    _isRecording = false;

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ampTimer?.cancel();
    _audioRecorder.dispose();
    _timerAmplitude!.cancel();
    super.dispose();
  }

  void _getAmplituder() {
    _timerAmplitude = Timer.periodic(
      const Duration(milliseconds: 40),
      (_) async {
        _incWidth++;
        _dcb = _amplitude!.current + 45;
        if (_dcb < 2) {
          _dcb = 2;
        }

        _listAmplitude.add(_dcb);
        setState(() {});
      },
    );
  }

  Widget _buildRecordStopControl() {
    late Widget icon;
    late Color color;

    if (_isRecording || _isPaused) {
      icon = Image.asset(
        AppIcons.stop,
        fit: BoxFit.fill,
      );
      color = Colors.red.withOpacity(0.1);
    } else {
      icon = const Icon(
        Icons.mic,
        color: AppColor.white,
        size: 70,
      );
      color = AppColor.pinkRec;
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(
            width: 80,
            height: 80,
            child: icon,
          ),
          onTap: () {
            _isRecording ? _stop() : _start();
          },
        ),
      ),
    );
  }

  Widget _amplitudRecords() {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        controller: _scrollController,
        itemCount: _listAmplitude.length,
        itemBuilder: (BuildContext context, int index) {
          _scrollController!
              .jumpTo(_scrollController!.position.maxScrollExtent);
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedContainer(
                duration: const Duration(
                  milliseconds: 50,
                ),
                height: _listAmplitude[index] * 3,
                width: 2.0,
                color: Colors.black,
              ),
              SizedBox(
                width: 2.0,
                height: 6.0,
                child: Container(
                  color: Colors.black,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildText() {
    if (_isRecording || _isPaused) {
      return _buildTimer();
    }

    return const Text('00:00');
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(
      _recordDuration ~/ 60,
    );
    final String seconds = _formatNumber(
      _recordDuration % 60,
    );
    context.read<RecordingsPageBloc>().add(
          RecordingsPageEvent(
            minutes: minutes,
            seconds: seconds,
          ),
        );
    return Text(
      '$minutes : $seconds',
      style: const TextStyle(
        color: Colors.red,
      ),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  Future<void> _start() async {
    try {
      var status = await Permission.microphone.shouldShowRequestRationale;
      if (status == false) {
        if (await _audioRecorder.hasPermission()) {
          await _audioRecorder.start();

          bool isRecording = await _audioRecorder.isRecording();
          setState(() {
            _isRecording = isRecording;
            _recordDuration = 0;
          });

          _startTimer();
          _getAmplituder();
        }
      } else {
        AlertDialogApp.instance.alertDialogPermission(
          context,
          'Разрешыть приложению записывать аудио?',
          Icons.mic,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    final path = await _audioRecorder.stop() ?? '';

    widget.onStop(path);
    setState(() => _isRecording = false);
    context.read<RecordingsPageBloc>().add(
          RecordingsPageEvent(
            path: path,
          ),
        );
  }

  void _startTimer() {
    _timer?.cancel();
    _ampTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });

    _ampTimer =
        Timer.periodic(const Duration(milliseconds: 200), (Timer t) async {
      _amplitude = await _audioRecorder.getAmplitude();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Отмена',
                style: kTitle3TextStyle3,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 50.0,
        ),
        const Text(
          'Запись',
          style: kBodyTextStyle,
        ),
        SizedBox(
          child: Column(
            children: [
              const SizedBox(
                height: 120.0,
              ),
              _amplitudRecords(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: const BoxDecoration(
                      color: AppColor.pink,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  _buildText(),
                ],
              ),
              const SizedBox(
                height: 40.0,
              ),
              _buildRecordStopControl(),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
