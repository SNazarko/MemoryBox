import 'package:flutter/material.dart';
import 'package:memory_box/pages/recordings_page/widgets/audio_player.dart';
import 'package:memory_box/pages/recordings_page/widgets/audio_recorder.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:memory_box/widgets/appbar_menu.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:provider/provider.dart';
import 'model_recordings_page.dart';

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
    final double screenHeight = MediaQuery.of(context).size.height;
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
                      height: screenHeight - 180.0,
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
