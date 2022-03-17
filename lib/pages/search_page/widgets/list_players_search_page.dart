import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/pages/save_page/save_page.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/widgets/player_mini/player_mini.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';
import 'package:provider/src/provider.dart';

import '../search_page_model.dart';

class ListPlayersSearchPage extends StatelessWidget {
  ListPlayersSearchPage({Key? key}) : super(key: key);
  final AudioRepositories repositories = AudioRepositories();
  Stream<List<AudioModel>> audio(BuildContext context) => FirebaseFirestore
      .instance
      .collection(repositories.user!.phoneNumber!)
      .doc('id')
      .collection('Collections')
      .where('searchName',
          arrayContains: context.watch<SearchPageModel>().getSearchData)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AudioModel.fromJson(doc.data())).toList());

  Widget buildAudio(AudioModel audio) => PlayerMini(
        duration: '${audio.duration}',
        url: '${audio.audioUrl}',
        name: '${audio.audioName}',
        popupMenu: _PopupMenuAudioSearchPage(
          url: '${audio.audioUrl}',
          duration: '${audio.duration}',
          name: '${audio.audioName}',
          image: '',
        ),
      );

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SearchPageModel>().getSearchData;
    final double screenHeight = MediaQuery.of(context).size.height;
    if (state == '') {
      return Column(
        children: [
          SizedBox(
            height: screenHeight * 0.95,
            child: StreamBuilder<List<AudioModel>>(
              stream: repositories.readAudio(),
              builder: (
                context,
                snapshot,
              ) {
                if (snapshot.hasError) {
                  return const Text('Ошибка');
                }
                if (snapshot.hasData) {
                  final audio = snapshot.data!;
                  return ListView(
                    padding: const EdgeInsets.only(top: 165, bottom: 110),
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
    } else {
      return Column(
        children: [
          SizedBox(
            height: screenHeight * 0.95,
            child: StreamBuilder<List<AudioModel>>(
              stream: audio(context),
              builder: (
                context,
                snapshot,
              ) {
                if (snapshot.hasError) {
                  return const Text('Ошибка');
                }
                if (snapshot.hasData) {
                  final audio = snapshot.data!;
                  return ListView(
                    padding: const EdgeInsets.only(top: 165, bottom: 110),
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
}

class _PopupMenuAudioSearchPage extends StatelessWidget {
  _PopupMenuAudioSearchPage({
    Key? key,
    required this.name,
    required this.url,
    required this.duration,
    required this.image,
  }) : super(key: key);
  final AudioRepositories repositories = AudioRepositories();
  final String name;
  final String url;
  final String duration;
  final String image;

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
          () {},
        ),
        popupMenuItem(
          'Поделиться',
          () {},
        ),
      ],
    );
  }
}
