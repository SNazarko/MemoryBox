import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';

const theSource = AudioSource.microphone;

class SoundRecord {
  Codec _codec = Codec.aacMP4;
  String _mPath = 'tau_file.mp4';
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  StreamSubscription? _mPlayerSubscription;
  double _mSubscriptionDuration = 0;
  int pos = 0;

  void initState(bool_mPlayerIsInited, bool _mRecorderIsInited,
      double _mSubscriptionDuration) {
    _mPlayer!.openAudioSession().then((value) {
      _mPlayerIsInited;
    });

    openTheRecorder().then((value) {
      _mRecorderIsInited;
    });

    _mPlayerSubscription = _mPlayer!.onProgress!.listen((e) {
      pos = e.position.inMilliseconds;
    });
    _mSubscriptionDuration;
  }

  void dispose() {
    _mPlayer!.closeAudioSession();
    _mPlayer = null;

    _mRecorder!.closeAudioSession();
    _mRecorder = null;

    cancelPlayerSubscriptions();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openAudioSession();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = 'tau_file.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    _mRecorderIsInited = true;
  }

  // ----------------------  Here is the code for recording and playback -------

  void record() {
    _mRecorder!
        .startRecorder(
          toFile: _mPath,
          codec: _codec,
          audioSource: theSource,
        )
        .then((value) {});
  }

  void stopRecorder(_mplaybackReady) async {
    await _mRecorder!.stopRecorder().then((value) {
      _mplaybackReady = true;
      // });
    });
  }

  void play(bool _mPlayerIsInited, bool _mplaybackReady) {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder!.isStopped &&
        _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
            fromURI: _mPath,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {})
        .then((value) {});
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {});
  }

  Future<void> setSubscriptionDuration(
      double d) async // v is between 0.0 and 2000 (milliseconds)
  {
    _mSubscriptionDuration = d;
    // setState(() {});
    await _mPlayer!.setSubscriptionDuration(
      Duration(milliseconds: d.floor()),
    );
  }

  void cancelPlayerSubscriptions() {
    if (_mPlayerSubscription != null) {
      _mPlayerSubscription!.cancel();
      _mPlayerSubscription = null;
    }
  }

// ----------------------------- UI --------------------------------------------
//
//   _Fn? getRecorderFn() {
//     if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
//       return null;
//     }
//     return _mRecorder!.isStopped ? record : stopRecorder;
//   }
//
//   _Fn? getPlaybackFn() {
//     if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder!.isStopped) {
//       return null;
//     }
//     return _mPlayer!.isStopped ? play : stopPlayer;
//   }
}
//   @override
//   Widget build(BuildContext context) {
//     Widget makeBody() {
//       return Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.all(3),
//             padding: const EdgeInsets.all(3),
//             height: 80,
//             width: double.infinity,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: Color(0xFFFAF0E6),
//               border: Border.all(
//                 color: Colors.indigo,
//                 width: 3,
//               ),
//             ),
//             child: Row(children: [
//               ElevatedButton(
//                 onPressed: getRecorderFn(),
//                 //color: Colors.white,
//                 //disabledColor: Colors.grey,
//                 child: Text(_mRecorder!.isRecording ? 'Stop' : 'Record'),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Text(_mRecorder!.isRecording
//                   ? 'Recording in progress'
//                   : 'Recorder is stopped'),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.all(3),
//             padding: const EdgeInsets.all(3),
//             height: 80,
//             width: double.infinity,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: Color(0xFFFAF0E6),
//               border: Border.all(
//                 color: Colors.indigo,
//                 width: 3,
//               ),
//             ),
//             child: Row(children: [
//               ElevatedButton(
//                 onPressed: getPlaybackFn(),
//                 //color: Colors.white,
//                 //disabledColor: Colors.grey,
//                 child: Text(_mPlayer!.isPlaying ? 'Stop' : 'Play'),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Text(_mPlayer!.isPlaying
//                   ? 'Playback in progress'
//                   : 'Player is stopped'),
//             ]),
//           ),
//         ],
//       );
//     }
//
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: AppBar(
//         title: const Text('Simple Recorder'),
//       ),
//       body: makeBody(),
//     );
//   }
// }

// import 'dart:async';
// import 'dart:io';
//
// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter_sound_lite/flutter_sound.dart';
// import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
// import 'package:intl/date_symbol_data_file.dart';
// import 'package:intl/intl.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path/path.dart' as path;
// import 'package:intl/intl.dart' show DateFormat;
//
// class SoundRecord {
//   final audioPlayer = AssetsAudioPlayer();
//   late String filePath;
//   late FlutterSoundRecorder _myRecorder;
//   // bool _play = false;
//   String recorderTxt = '00:00:00';
//
//   void startIt() async {
//     filePath = '/sdcard/Download/temp.wav';
//     _myRecorder = FlutterSoundRecorder();
//
//     await _myRecorder.openAudioSession(
//         focus: AudioFocus.requestFocusAndStopOthers,
//         category: SessionCategory.playAndRecord,
//         mode: SessionMode.modeDefault,
//         device: AudioDevice.speaker);
//     await _myRecorder.setSubscriptionDuration(const Duration(milliseconds: 10));
//     // await initializeDateFormatting();
//
//     await Permission.microphone.request();
//     await Permission.storage.request();
//     await Permission.manageExternalStorage.request();
//   }
//
//   Future<void> record() async {
//     Directory dir = Directory(path.dirname(filePath));
//     if (!dir.existsSync()) {
//       dir.createSync();
//     }
//     _myRecorder.openAudioSession();
//     await _myRecorder.startRecorder(
//       toFile: filePath,
//       codec: Codec.pcm16WAV,
//     );
//
//     StreamSubscription _recorderSubscription =
//         _myRecorder.onProgress!.listen((e) {
//       var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
//           isUtc: true);
//       var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
//       recorderTxt = txt.substring(0, 8);
//     });
//     _recorderSubscription.cancel();
//   }
//
//   Future<String?> stopRecord() async {
//     _myRecorder.closeAudioSession();
//     return await _myRecorder.stopRecorder();
//   }
//
//   Future<void> startPlaying() async {
//     audioPlayer.open(
//       Audio.file(filePath),
//       autoStart: true,
//       showNotification: true,
//     );
//   }
//
//   Future<void> stopPlaying() async {
//     audioPlayer.stop();
//   }
// }

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
