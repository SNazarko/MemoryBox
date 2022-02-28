import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/bloc_all/bloc_all_bloc.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/player_mini.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';
import '../resources/constants.dart';

class AudioRecordingsPage extends StatelessWidget {
  const AudioRecordingsPage({Key? key}) : super(key: key);
  static const routeName = '/audio_recordings_page';
  static Widget create() {
    return const AudioRecordingsPage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayAllRepeatBloc(),
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
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
              color: Colors.white,
              iconSize: 30.0,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  _ListPlayers(),
                  const _AppbarHeader(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppbarHeader extends StatelessWidget {
  const _AppbarHeader({Key? key}) : super(key: key);
  final int qualityAudio = 20;
  final String time = '10:30';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(),
        ClipPath(
          clipper: AppbarClipper(),
          child: Container(
            color: AppColor.colorAppbar,
            width: double.infinity,
            height: 125.0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Все в одном месте',
              style: kTitle2TextStyle2,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
            left: 10.0,
            right: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$qualityAudio аудио',
                    style: kTitle2TextStyle2,
                  ),
                  Text(
                    '$time часов',
                    style: kTitle2TextStyle2,
                  ),
                ],
              ),
              _AppbarPlayer(),
            ],
          ),
        )
      ],
    );
  }
}

class _AppbarPlayer extends StatelessWidget {
  const _AppbarPlayer({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final PlayAllRepeatBloc playAllRepeat = context.read<PlayAllRepeatBloc>();
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            playAllRepeat.add(
              RepeatEvent(),
            );
          },
          child: BlocBuilder<PlayAllRepeatBloc, Color>(
            builder: (context, state) {
              return Container(
                height: 46.0,
                width: 200.0,
                decoration: BoxDecoration(
                    color: state,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50.0),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      child: Image.asset(
                        AppIcons.vector,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            playAllRepeat.add(
              PlayAllEvent(),
            );
          },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 1.0, top: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    child: Image.asset(
                      AppIcons.play_aud,
                    ),
                  ),
                  const Text(
                    'Запустить все',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColor.blue100,
                    ),
                  ),
                ],
              ),
            ),
            height: 46.0,
            width: 150.0,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                )),
          ),
        ),
      ],
    );
  }
}

class _ListPlayers extends StatelessWidget {
  _ListPlayers({Key? key}) : super(key: key);
  final AudioRepositories repositories = AudioRepositories();
  Widget buildAudio(AudioModel audio) => PlayerMini(
        duration: '${audio.duration}',
        url: '${audio.audioUrl}',
        name: '${audio.audioName}',
        popupMenu: const PopupMenuAudioRecordingPage(),
      );

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.95,
          child: StreamBuilder<List<AudioModel>>(
            stream: repositories.readAudio(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Ошибка');
              }
              if (snapshot.hasData) {
                final audio = snapshot.data!;
                return ListView(
                  padding: const EdgeInsets.only(top: 127, bottom: 110),
                  children: audio.map(buildAudio).toList(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class PopupMenuAudioRecordingPage extends StatelessWidget {
  const PopupMenuAudioRecordingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_horiz,
      ),
      iconSize: 40,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      itemBuilder: (context) => [
        popupMenuItem('Переименовать', () {}, 0),
        popupMenuItem('Добавить в подборку', () {}, 1),
        popupMenuItem('Удалить ', () {}, 2),
        popupMenuItem('Поделиться', () {}, 3),
      ],
    );
  }
}
