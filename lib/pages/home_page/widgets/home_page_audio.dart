import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/models/view_model.dart';
import 'package:memory_box/pages/save_page/save_page_model.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/player_mini/player_mini.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';
import 'package:provider/provider.dart';
import '../../../repositories/user_repositories.dart';
import '../../../widgets/alert_dialog.dart';
import '../../save_page/save_page.dart';

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

  @override
  Widget build(BuildContext context) {
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
            onTap: () {
              Provider.of<Navigation>(context, listen: false).setCurrentIndex =
                  3;
            },
            child: const Text(
              'Открыть все',
              style: TextStyle(fontSize: 14.0),
            ),
          )
        ],
      ),
    );
  }
}

class PopupMenuHomePage extends StatelessWidget {
  PopupMenuHomePage({
    Key? key,
    required this.name,
    required this.url,
    required this.duration,
    required this.image,
    required this.done,
    required this.dateTime,
    required this.searchName,
    required this.idAudio,
    required this.collection,
  }) : super(key: key);
  final AudioRepositories repositories = AudioRepositories();
  final String name;
  final String url;
  final String duration;
  final String image;
  final bool done;
  final String dateTime;
  final List searchName;
  final String idAudio;
  final List collection;
  void init(BuildContext context) {
    context.read<SavePageModel>().setCollection(collection);
    context.read<SavePageModel>().setIdAudio(idAudio);
    context.read<SavePageModel>().setAudioName(name);
    context.read<SavePageModel>().setAudioUrl(url);
    context.read<SavePageModel>().setDuration(duration);
    context.read<SavePageModel>().setDone(done);
    context.read<SavePageModel>().setDateTime(dateTime);
    context.read<SavePageModel>().setSearchName(searchName);
  }

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
        popupMenuItem(
          'Переименовать',
          () {
            Timer(const Duration(seconds: 1), () {
              init(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SavePage(
                  image: image,
                  url: url,
                  duration: duration,
                  name: name,
                );
              }));
            });
          },
        ),
        popupMenuItem(
          'Добавить в подборку',
          () {},
        ),
        popupMenuItem(
          'Удалить ',
          () {
            AlertDialogApp().alertDialog(
              context,
              idAudio,
              'DeleteCollections',
              'Collections',
            );
          },
        ),
        popupMenuItem(
          'Поделиться',
          () {
            repositories.downloadAudio(idAudio, name);
          },
        ),
      ],
    );
  }
}
