import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/appbar_header_audio_recordings.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/appbar_header_audio_recordings_not_authorization.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/list_player.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/list_player_not_authorization.dart';
import 'package:provider/provider.dart';
import '../../animation/audio_recordings_page_player/audio_recordings_page_player_model.dart';
import '../../blocs/list_item_bloc/list_item_bloc.dart';
import '../../repositories/audio_repositories.dart';
import '../../repositories/user_repositories.dart';
import '../../utils/constants.dart';
import '../../widgets/player/player_collections/player_collections.dart';
import 'blocs/bloc_quality_total_time/quality_total_time_bloc.dart';
import 'blocs/bloc_quality_total_time/quality_total_time_event.dart';

class AudioRecordingsPage extends StatelessWidget {
  AudioRecordingsPage({Key? key}) : super(key: key);
  final UserRepositories rep = UserRepositories();
  final AudioRepositories repAudio = AudioRepositories();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListItemBloc>(
          create: (context) => ListItemBloc()
            ..add(
              LoadListItemEvent(
                  streamList: AudioRepositories().readAudioSort('all')),
            ),
        ),
        BlocProvider<QualityTotalTimeBloc>(
          create: (context) => QualityTotalTimeBloc(
            repositories: UserRepositories(),
          )..add(
              LoadQualityTotalTimeEvent(),
            ),
        ),
      ],
      child: Scaffold(
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
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      rep.user == null
                          ? const ListPlayerNotAuthorization()
                          : const ListPlayer(),
                      rep.user == null
                          ? const AppbarHeaderAudioRecordingsNotAuthorization()
                          : AppbarHeaderAudioRecordings(),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
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
      ),
    );
  }
}
