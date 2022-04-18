import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../repositories/audio_repositories.dart';
import '../../../repositories/local_save_audiofile.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_icons.dart';
import '../../../utils/constants.dart';
import '../../../widgets/uncategorized/slider.dart';
import '../model_recordings_page.dart';

class AudioPlayer extends StatefulWidget {
  /// Path from where to play recorded audio
  final ap.AudioSource source;

  /// Callback when audio file should be removed
  /// Setting this to null hides the delete button
  final VoidCallback onDelete;

  AudioPlayer({
    required this.source,
    required this.onDelete,
  });

  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  final UserRepositories _rep = UserRepositories();
  static const double _controlSize = 56;
  static const double _deleteBtnSize = 24;

  final _audioPlayer = ap.AudioPlayer();
  late StreamSubscription<ap.PlayerState> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;
  String _saveRecord = 'Аудиофайл';
  bool _isPlay = false;
  bool _isPaused = false;
  Timer? _timer;
  int _recordDuration = 0;
  final Set searchName = {};

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
    await _audioPlayer.setAudioSource(widget.source);
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

  Future<void> shareAudio(BuildContext context) async {
    Directory directory = await getTemporaryDirectory();
    final filePath = directory.path + '/$_saveRecord.mp3';
    var file = File(filePath);
    var fileTemp = File(Provider.of<ModelRP>(context, listen: false).getData);
    var isExist = await file.exists();
    if (!isExist) {
      await file.create();
    }
    var rat = await fileTemp.readAsBytes();
    await file.writeAsBytes(rat);
    await Share.shareFiles(
      [filePath],
    );
  }

  Future<void> logicSave() async {
    await FirebaseFirestore.instance
        .collection(_rep.user!.phoneNumber!)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        final bool subscription = result.data()['subscription'] ?? true;
        _rep.user == null
            ? saveRecordLocal()
            : subscription
                ? saveRecordsFirebase()
                : saveRecordLocal();
      }
    });
  }

  void saveRecordLocal() {
    LocalSaveAudioFile().saveAudioStorageDirectory(
      context,
      Provider.of<ModelRP>(context, listen: false).getData,
      _saveRecord,
    );
    _audioPlayer.stop().then((value) => widget.onDelete());
  }

  void saveRecordsFirebase() async {
    _audioPlayer.stop().then((value) => widget.onDelete());
    await AudioRepositories().addAudio(
      Provider.of<ModelRP>(context, listen: false).getData,
      _saveRecord,
      Provider.of<ModelRP>(context, listen: false).getDuration,
      searchName,
    );
    await _rep.updateTotalTimeQuality();
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
    // _ampTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  Widget _buildControl() {
    Widget icon;

    if (_audioPlayer.playerState.playing) {
      icon = Image.asset(
        AppIcons.stop,
        fit: BoxFit.fill,
      );
    } else {
      icon = Container(
        color: Colors.transparent,
        child: Expanded(
          child: Image.asset(
            'assets/images/playR.png',
            fit: BoxFit.fill,
          ),
        ),
      );
    }

    return ClipOval(
      child: Material(
        child: InkWell(
          child: SizedBox(
            width: 80,
            height: 80,
            child: icon,
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

  Widget _icon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Row(
            children: [
              IconButton(
                onPressed: () => shareAudio(context),
                icon: Image.asset(AppIcons.rec_upload),
              ),
              IconButton(
                  onPressed: () => saveRecordLocal(),
                  icon: Image.asset(AppIcons.rec_paper_download),
                  padding: const EdgeInsets.symmetric(horizontal: 15.0)),
              IconButton(
                  onPressed: () =>
                      _audioPlayer.stop().then((value) => widget.onDelete()),
                  icon: Image.asset(AppIcons.rec_delete),
                  padding: const EdgeInsets.symmetric(horizontal: 15)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35.0),
          child: TextButton(
            onPressed: () => logicSave(),
            child: const Text(
              'Сохранить',
              style: kTitle3TextStyle3,
            ),
          ),
        ),
      ],
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _icon(),
            const SizedBox(
              height: 75.0,
            ),
            SizedBox(
              width: 200.0,
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Аудиофайл',
                  hintStyle:
                      TextStyle(fontSize: 24.0, color: AppColor.colorText),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24.0),
                onChanged: (value) {
                  _saveRecord = value;
                  final data = value.toLowerCase();
                  searchName.add(data);
                  if (data != searchName.last) {
                    searchName.remove(searchName.last);
                  }
                },
              ),
            ),
            const SizedBox(
              height: 100.0,
            ),
            _buildSlider(constraints.maxWidth),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildText(),
                  Text(
                      '${Provider.of<ModelRP>(context, listen: false).getDuration}'),
                ],
              ),
            ),
            const SizedBox(
              height: 70.0,
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
            const SizedBox(
              height: 20.0,
            ),
          ],
        );
      },
    );
  }
}
