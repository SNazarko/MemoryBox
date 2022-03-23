import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/view_model.dart';

import 'package:memory_box/pages/audio_recordings_page/audio_recordings_page.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/repositories/local_save_audiofile.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_menu.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:memory_box/widgets/slider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import '../../repositories/user_repositories.dart';
import 'model_recordings_page.dart';

class _RecordPageArguments {
  _RecordPageArguments({this.auth, this.user}) {
    init();
  }
  FirebaseAuth? auth;
  User? user;

  void init() {
    auth = FirebaseAuth.instance;
    user = auth!.currentUser;
  }
}

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);
  static const routeName = '/record_page';
  static Widget create() {
    return ChangeNotifierProvider<ModelRP>(
        create: (BuildContext context) => ModelRP(), child: const RecordPage());
  }

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  bool showPlayer = false;
  ap.AudioSource? audioSource;
  String? path;

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                const AppbarMenu(),
                Positioned(
                    left: 5.0,
                    top: 30.0,
                    child: Container(
                      height: 520.0,
                      width: screenWidth * 0.97,
                      decoration: kBorderContainer2,
                      child: showPlayer
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: AudioPlayer(
                                source: audioSource!,
                                onDelete: () {
                                  setState(() => showPlayer = false);
                                },
                              ),
                            )
                          : AudioRecorder(
                              onStop: (path) {
                                setState(() {
                                  audioSource =
                                      ap.AudioSource.uri(Uri.parse(path));
                                  showPlayer = true;
                                });
                              },
                            ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
  Record? _record;
  double _dcb = 0;
  List _listAmplitude = [];
  ScrollController? _scrollController = ScrollController();

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

  @override
  Widget build(BuildContext context) {
    return Column(
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
          height: 50,
        ),
        const Text(
          'Запись',
          style: kBodiTextStyle,
        ),
        const SizedBox(
          height: 120,
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
          height: 40,
        ),
        _buildRecordStopControl(),
      ],
    );
  }

  void _getAmplituder() {
    _timerAmplitude = Timer.periodic(
      const Duration(milliseconds: 40),
      (_) async {
        _incWidth++;
        // _amplitude = await _record!.getAmplitude();
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
      icon = Icon(Icons.mic, color: AppColor.white, size: 70);
      color = AppColor.pinkRec;
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 80, height: 80, child: icon),
          onTap: () {
            _isRecording ? _stop() : _start();
          },
        ),
      ),
    );
  }

  // Widget _buildPauseResumeControl() {
  //   if (!_isRecording && !_isPaused) {
  //     return const SizedBox.shrink();
  //   }
  //
  //   late Icon icon;
  //   late Color color;
  //
  //   if (!_isPaused) {
  //     icon = Icon(Icons.pause, color: Colors.red, size: 30);
  //     color = Colors.red.withOpacity(0.1);
  //   } else {
  //     final theme = Theme.of(context);
  //     icon = Icon(Icons.play_arrow, color: Colors.red, size: 30);
  //     color = theme.primaryColor.withOpacity(0.1);
  //   }
  //
  //   return ClipOval(
  //     child: Material(
  //       color: color,
  //       child: InkWell(
  //         child: SizedBox(width: 56, height: 56, child: icon),
  //         onTap: () {
  //           _isPaused ? _resume() : _pause();
  //         },
  //       ),
  //     ),
  //   );
  // }

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
                duration: const Duration(milliseconds: 50),
                height: _listAmplitude[index] * 3,
                width: 2,
                color: Colors.black,
              ),
              SizedBox(
                width: 2,
                height: 6,
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

    return Text('00:00');
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);
    context.read<ModelRP>().setDuration(minutes, seconds);
    return Text(
      '$minutes : $seconds',
      style: const TextStyle(color: Colors.red),
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
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    final path = await _audioRecorder.stop() ?? '';

    widget.onStop(path);
    setState(() => _isRecording = false);
    context.read<ModelRP>().changeString(path);
  }

  Future<void> _pause() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    await _audioRecorder.pause();

    setState(() => _isPaused = true);
  }

  Future<void> _resume() async {
    _startTimer();
    await _audioRecorder.resume();

    setState(() => _isPaused = false);
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
}

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
  final _RecordPageArguments _arguments = _RecordPageArguments();
  static const double _controlSize = 56;
  static const double _deleteBtnSize = 24;

  final _audioPlayer = ap.AudioPlayer();
  late StreamSubscription<ap.PlayerState> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;
  // final TextEditingController _controller =
  //     TextEditingController(text: 'Аудиофайл');
  String _saveRecord = 'Аудиофайл';
  bool _isPlay = false;
  bool _isPaused = false;
  Timer? _timer;
  Timer? _ampTimer;
  Amplitude? _amplitude;
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
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
                // controller: _controller,
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
          ],
        );
      },
    );
  }

  Widget _icon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {},
          icon: Image.asset(AppIcons.rec_upload),
        ),
        IconButton(
            onPressed: () {
              saveRecordLocal();
            },
            icon: Image.asset(AppIcons.rec_paper_download),
            padding: const EdgeInsets.symmetric(horizontal: 15.0)),
        IconButton(
            onPressed: () {
              _audioPlayer.stop().then((value) => widget.onDelete());
            },
            icon: Image.asset(AppIcons.rec_delete),
            padding: const EdgeInsets.symmetric(horizontal: 15)),
        Padding(
          padding: const EdgeInsets.only(left: 35.0),
          child: TextButton(
            onPressed: () {
              _arguments.user == null
                  ? saveRecordLocal()
                  : saveRecordsFirebase();
            },
            child: const Text(
              'Сохранить',
              style: kTitle3TextStyle3,
            ),
          ),
        ),
      ],
    );
  }

  void saveRecordLocal() {
    LocalSaveAudioFile().saveAudioStorageDirectory(
      Provider.of<ModelRP>(context, listen: false).getData,
      _saveRecord,
    );
    _audioPlayer.stop().then((value) => widget.onDelete());
  }

  void saveRecordsFirebase() {
    AudioRepositories().uploadAudio(
      Provider.of<ModelRP>(context, listen: false).getData,
      _saveRecord,
      Provider.of<ModelRP>(context, listen: false).getDuration,
      searchName,
    );
    UserRepositories().updateTotalTimeQuality();
    _audioPlayer.stop().then((value) => widget.onDelete());
  }

  Widget _buildControl() {
    Widget icon;

    if (_audioPlayer.playerState.playing) {
      icon = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Image.asset(
            AppIcons.stop,
            fit: BoxFit.fill,
          ),
        ),
      );
    } else {
      icon = Container(
        child: Image.asset(
          AppIcons.play,
          fit: BoxFit.fill,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ClipOval(
        child: Material(
          child: InkWell(
            child: SizedBox(width: 97, height: 97, child: icon),
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
            thumbShape: RoundedAmebaThumbShape(radius: 8),
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
    // _ampTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });

    // _ampTimer =
    //     Timer.periodic(const Duration(milliseconds: 200), (Timer t) async {
    //       _amplitude = await _audioRecorder.getAmplitude();
    //       setState(() {});
    //     });
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
