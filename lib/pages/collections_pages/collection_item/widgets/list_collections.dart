import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit_audio/collection_item_edit_audio.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/widgets/button/popup_menu_button.dart';

import '../../../../widgets/button/alert_dialog.dart';
import '../../../../widgets/player/player_mini/player_mini.dart';
import '../../../save_page/save_page.dart';

class ListCollectionsAudio extends StatelessWidget {
  const ListCollectionsAudio({
    Key? key,
    required this.idCollection,
    required this.imageCollection,
  }) : super(key: key);
  final String idCollection;
  final String imageCollection;

  Widget buildAudio(AudioModel audio) => PlayerMini(
        playPause: audio.playPause,
        duration: '${audio.duration}',
        url: '${audio.audioUrl}',
        name: '${audio.audioName}',
        done: audio.done!,
        id: '${audio.id}',
        collection: audio.collections ?? [],
        popupMenu: _PopupMenuPlayerMini(
          image: '',
          duration: '${audio.duration}',
          name: '${audio.audioName}',
          url: '${audio.audioUrl}',
          done: audio.done!,
          searchName: audio.searchName!,
          dateTime: audio.dateTime!,
          collection: audio.collections!,
          idAudio: '${audio.id}',
          imageCollection: imageCollection,
        ),
      );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder<List<AudioModel>>(
        stream: AudioRepositories.instance.readAudioSort(idCollection),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Ошибка');
          }
          if (snapshot.hasData) {
            final audio = snapshot.data!;
            // print(i)
            return ListView(
              padding: const EdgeInsets.only(bottom: 140.0),
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

class _PopupMenuPlayerMini extends StatelessWidget {
  const _PopupMenuPlayerMini({
    Key? key,
    required this.name,
    required this.url,
    required this.duration,
    required this.image,
    required this.dateTime,
    required this.searchName,
    required this.done,
    required this.idAudio,
    required this.collection,
    required this.imageCollection,
  }) : super(key: key);
  final String name;
  final String url;
  final String duration;
  final String image;
  final String dateTime;
  final List searchName;
  final bool done;
  final String idAudio;
  final List collection;
  final String imageCollection;

  void _rename(BuildContext context, String imageCollection) {
    Timer(const Duration(seconds: 1), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SavePage(
          audioUrl: url,
          audioImage: imageCollection,
          audioDone: done,
          audioTime: dateTime,
          audioSearchName: searchName,
          audioCollection: collection,
          idAudio: idAudio,
          audioDuration: duration,
          audioName: name,
        );
      }));
    });
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
          () => _rename(context, imageCollection),
        ),
        popupMenuItem(
          'Добавить в подборку',
          () => Timer(const Duration(seconds: 1), () {
            Navigator.pushNamed(context, CollectionItemEditAudio.routeName);
          }),
        ),
        popupMenuItem(
          'Удалить ',
          () => AlertDialogApp().alertDialog(
            context,
            idAudio,
            'DeleteCollections',
            'Collections',
          ),
        ),
        popupMenuItem(
          'Поделиться',
          () => AudioRepositories.instance.downloadAudio(idAudio, name),
        ),
      ],
    );
  }
}
