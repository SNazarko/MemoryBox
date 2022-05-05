import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/models/view_model.dart';
import 'package:memory_box/pages/home_page/widgets/popup_menu_home_page.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../Blocs/navigation_bloc/navigation__bloc.dart';
import '../../../Blocs/navigation_bloc/navigation__event.dart';
import '../../../Blocs/navigation_bloc/navigation__state.dart';
import '../../../widgets/player/player_mini/player_mini.dart';
import '../../audio_recordings_page/audio_recordings_page.dart';

class HomePageAudio extends StatelessWidget {
  const HomePageAudio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0.0, -5.0),
              blurRadius: 10.0,
            )
          ]),
      child: Container(
        decoration: kBorderContainer2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Expanded(
              flex: 1,
              child: _TitleAudioList(),
            ),
            Expanded(
              flex: 5,
              child: _AudioList(),
            )
          ],
        ),
      ),
    );
  }
}

class _AudioList extends StatelessWidget {
  _AudioList({Key? key}) : super(key: key);
  final AudioRepositories repositories = AudioRepositories();

  Widget buildAudio(AudioModel audio) => PlayerMini(
        duration: '${audio.duration}',
        url: '${audio.audioUrl}',
        name: '${audio.audioName}',
        done: audio.done!,
        id: '${audio.id}',
        collection: audio.collections!,
        popupMenu: PopupMenuHomePage(
          url: '${audio.audioUrl}',
          duration: '${audio.duration}',
          name: '${audio.audioName}',
          image: '',
          done: audio.done!,
          searchName: audio.searchName!,
          dateTime: audio.dateTime!,
          idAudio: '${audio.id}',
          collection: audio.collections!,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder<List<AudioModel>>(
        stream: repositories.readAudioSort('all'),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 50.0,
                horizontal: 40.0,
              ),
              child: Text(
                'Как только ты запишешь аудио, она появится здесь.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: AppColor.colorText50,
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            final audio = snapshot.data!;
            if (audio.map(buildAudio).toList().isEmpty) {
              UserRepositories().firstAuthorization();
              return const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 50.0,
                  horizontal: 40.0,
                ),
                child: Text(
                  'Как только ты запишешь аудио, она появится здесь.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: AppColor.colorText50,
                  ),
                ),
              );
            }

            return ListView(
              children: audio.map(buildAudio).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _TitleAudioList extends StatelessWidget {
  const _TitleAudioList({Key? key}) : super(key: key);
  void _navigateToPage(
    BuildContext context, {
    required int index,
    required int currentIndex,
    required String route,
  }) {
    Navigator.pop(context);

    if (index != currentIndex) {
      context.read<NavigationBloc>().add(
            NavigateMenu(
              menuIndex: index,
              route: route,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Аудиозаписи',
                style: TextStyle(fontSize: 24.0),
              ),
              GestureDetector(
                onTap: () => _navigateToPage(context,
                    index: 3,
                    currentIndex: state.currentIndex,
                    route: AudioRecordingsPage.routeName),
                // {
                //   Provider.of<Navigation>(context, listen: false).setCurrentIndex =
                //       3;
                // },
                child: const Text(
                  'Открыть все',
                  style: TextStyle(fontSize: 14.0),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
