import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart' show DateFormat;

class SoundRecord {
  final audioPlayer = AssetsAudioPlayer();
  late String filePath;
  late FlutterSoundRecorder _myRecorder;
  // bool _play = false;
  String recorderTxt = '00:00:00';

  void startIt() async {
    filePath = '/sdcard/Download/temp.wav';
    _myRecorder = FlutterSoundRecorder();

    await _myRecorder.openAudioSession(
        focus: AudioFocus.requestFocusAndStopOthers,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);
    await _myRecorder.setSubscriptionDuration(const Duration(milliseconds: 10));
    // await initializeDateFormatting();

    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  Future<void> record() async {
    Directory dir = Directory(path.dirname(filePath));
    if (!dir.existsSync()) {
      dir.createSync();
    }
    _myRecorder.openAudioSession();
    await _myRecorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );

    StreamSubscription _recorderSubscription =
        _myRecorder.onProgress!.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
          isUtc: true);
      var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
      recorderTxt = txt.substring(0, 8);
    });
    _recorderSubscription.cancel();
  }

  Future<String?> stopRecord() async {
    _myRecorder.closeAudioSession();
    return await _myRecorder.stopRecorder();
  }

  Future<void> startPlaying() async {
    audioPlayer.open(
      Audio.file(filePath),
      autoStart: true,
      showNotification: true,
    );
  }

  Future<void> stopPlaying() async {
    audioPlayer.stop();
  }
}

// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_sound_lite/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class SoundRecord {
//   FlutterSoundRecorder? _audioRecorder;
//   final pathToSaveAudio = 'audio_example.aac';
//   bool _isRecorderInitialised = false;
//   bool get isRecording => _audioRecorder!.isRecording;
//
//   Future init() async {
//     _audioRecorder = FlutterSoundRecorder();
//     final status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       throw RecordingPermissionException('Microphone permission');
//     }
//     _audioRecorder!.openAudioSession();
//     _isRecorderInitialised = true;
//   }
//
//   Future dispose() async {
//     if (!_isRecorderInitialised) return;
//     _audioRecorder!.closeAudioSession();
//     _audioRecorder = null;
//     _isRecorderInitialised = false;
//   }
//
//   Future _record() async {
//     if (!_isRecorderInitialised) return;
//     await _audioRecorder!.startRecorder(toFile: pathToSaveAudio);
//   }
//
//   Future _stop() async {
//     if (!_isRecorderInitialised) return;
//     await _audioRecorder!.stopRecorder();
//   }
//
//   Future toggleRecorder() async {
//     if (_audioRecorder!.isStopped) {
//       await _record();
//     } else {
//       await _stop();
//     }
//   }
// }
//
// class TimerWidget extends StatefulWidget {
//   final TimerController timerController;
//   const TimerWidget({Key? key, required this.timerController})
//       : super(key: key);
//
//   @override
//   _TimerWidgetState createState() => _TimerWidgetState();
// }
//
// class _TimerWidgetState extends State<TimerWidget> {
//   Duration duration = Duration();
//   Timer? timer;
//   @override
//   void initState() {
//     widget.timerController.addListener(() {
//       if (widget.timerController.value) {
//         startTimer();
//       } else {
//         stopTimer();
//       }
//     });
//     super.initState();
//   }
//
//   void reset() => setState(() => duration = Duration());
//
//   void addTime() {
//     final addSecond = 1;
//     setState(() {
//       final second = duration.inSeconds + addSecond;
//       if (second < 0) {
//         timer?.cancel();
//       } else {
//         duration = Duration(seconds: second);
//       }
//     });
//   }
//
//   void startTimer({bool resets = true}) {
//     if (!mounted) return;
//     if (resets) {
//       reset();
//     }
//     timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
//   }
//
//   void stopTimer({bool resets = true}) {
//     if (!mounted) return;
//     if (resets) {
//       reset();
//     }
//     setState(() => timer?.cancel());
//   }
//
//   @override
//   Widget build(BuildContext context) => Center(
//       // child: bildTime(),
//       );
// }
//
// class TimerController extends ValueNotifier<bool> {
//   TimerController({bool isPlaying = false}) : super(isPlaying);
//   void startTimer() => value = true;
//   void stopTimer() => value = false;
// }
