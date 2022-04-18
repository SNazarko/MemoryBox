import 'dart:async';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:flutter/cupertino.dart';

class PlayerCollectionModel extends ChangeNotifier {
  final _audioPlayer = ap.AudioPlayer();
  late StreamSubscription<ap.PlayerState> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;
  bool _isPlay = false;
  bool _isPaused = false;
  // PlayerCollectionModel() {
  //   _init();
  // }
  //
  // Future<void> _init() async {
  //   _isPlay = false;
  //   notifyListeners();
  //   _playerStateChangedSubscription =
  //       _audioPlayer.playerStateStream.listen((state) async {
  //     if (state.processingState == ap.ProcessingState.completed) {
  //       await PlayerCollectionsState().stop();
  //     }
  //     notifyListeners();
  //   });
  //   _positionChangedSubscription =
  //       _audioPlayer.positionStream.listen((position) => notifyListeners());
  //   _durationChangedSubscription =
  //       _audioPlayer.durationStream.listen((duration) => notifyListeners());
  //   PlayerCollectionsState().player();
  // }

  get getIsPlay => _isPlay;
  get getIsPaused => _isPaused;

  Future<void> play() {
    _isPlay = true;
    notifyListeners();
    // PlayerCollectionsState().startTimer();
    return _audioPlayer.play();
  }
}
