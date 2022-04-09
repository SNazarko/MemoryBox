import 'package:flutter/material.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/appbar_header_audio_recordings.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/appbar_header_audio_recordings_not_authorization.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/list_player.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/list_player_not_authorization.dart';
import 'package:provider/provider.dart';
import '../../animation/audio_recordings_page_player/audio_recordings_page_player_model.dart';
import '../../repositories/user_repositories.dart';
import '../../resources/constants.dart';
import '../../widgets/player_collections/player_collections.dart';

class AudioRecordingsPage extends StatelessWidget {
  AudioRecordingsPage({Key? key}) : super(key: key);
  final UserRepositories rep = UserRepositories();
  static const routeName = '/audio_recordings_page';
  static Widget create() {
    return ChangeNotifierProvider<AudioRecordingsPagePlayerModel>(
      create: (BuildContext context) => AudioRecordingsPagePlayerModel(),
      child: AudioRecordingsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        elevation: 0.0,
        title: const Text(
          'Аудиозаписи',
          style: kTitleTextStyle2,
        ),
        actions: [
          rep.user == null
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    UserRepositories().updateTotalTimeQuality();
                  },
                  child: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  rep.user == null
                      ? const ListPlayerNotAuthorization()
                      : ListPlayer(),
                  rep.user == null
                      ? const AppbarHeaderAudioRecordingsNotAuthorization()
                      : AppbarHeaderAudioRecordings(),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70.0),
              child: PlayerCollections(
                screenWight: screenWight,
                screenHeight: screenHeight,
                idCollection: 'all',
                animation:
                    context.watch<AudioRecordingsPagePlayerModel>().getAnim,
              ),
            ),
          )
        ],
      ),
    );
  }
}
