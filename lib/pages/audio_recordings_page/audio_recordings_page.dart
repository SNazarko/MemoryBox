import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/appbar_header_audio_recordings.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/appbar_header_audio_recordings_not_authorization.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/list_player.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/list_player_not_authorization.dart';
import 'package:memory_box/repositories/auth_repositories.dart';
import '../../blocs/list_item_bloc/list_item_bloc.dart';
import '../../utils/constants.dart';
import '../../widgets/player/player_collections/player_collections.dart';
import 'blocs/bloc_anim/anim_bloc.dart';
import 'blocs/bloc_quality_total_time/quality_total_time_bloc.dart';
import 'blocs/bloc_quality_total_time/quality_total_time_event.dart';

class AudioRecordingsPage extends StatelessWidget {
  const AudioRecordingsPage({Key? key}) : super(key: key);
  static const routeName = '/audio_recordings_page';
  final bool shouldPop = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWight = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider<AnimBloc>(
          create: (context) => AnimBloc(),
        ),
        BlocProvider<ListItemBloc>(
          create: (context) => ListItemBloc()
            ..add(
              LoadListItemEvent(
                sort: 'all',
                collection: 'Collections',
                nameSort: 'collections',
              ),
            ),
        ),
        BlocProvider<QualityTotalTimeBloc>(
          create: (context) => QualityTotalTimeBloc()
            ..add(
              LoadQualityTotalTimeEvent(),
            ),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          return shouldPop;
        },
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
                        AuthRepositories.instance.user == null
                            ? const ListPlayerNotAuthorization()
                            : const ListPlayer(),
                        AuthRepositories.instance.user == null
                            ? const AppbarHeaderAudioRecordingsNotAuthorization()
                            : const AppbarHeaderAudioRecordings(),
                      ],
                    ),
                  ],
                ),
              ),
              BlocBuilder<AnimBloc, AnimState>(
                builder: (_, state) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: PlayerCollections(
                        screenWight: screenWight,
                        screenHeight: screenHeight,
                        idCollection: 'all',
                        animation: state.anim,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
