import 'dart:html';

import 'package:flutter_sound_lite/flutter_sound.dart';

class SoundRecord {
  FlutterSoundRecorder? _audioRecorder;
  final pathToSaveAudio = 'audio_example.aac';
  bool _isRecorderInitialised = false;
  bool get isRecording => _audioRecorder!.isRecording;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission');
    }
    _audioRecorder!.openAudioSession();
    _isRecorderInitialised = true;
  }

  Future dispose() async {
    if (!_isRecorderInitialised) return;
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialised = false;
  }

  Future _record() async {
    if (!_isRecorderInitialised) return;
    await _audioRecorder!.startRecorder(toFile: pathToSaveAudio);
  }

  Future _stop() async {
    if (!_isRecorderInitialised) return;
    await _audioRecorder!.stopRecorder();
  }

  Future toggleRecorder() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}
