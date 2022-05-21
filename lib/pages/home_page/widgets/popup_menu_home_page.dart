import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memory_box/widgets/button/popup_menu_button.dart';

import '../../../repositories/audio_repositories.dart';
import '../../../widgets/button/alert_dialog.dart';
import '../../collections_pages/collection_add_audio_in_collection/collection_add_audio_in_collection.dart';
import '../../save_page/save_page.dart';

class PopupMenuHomePage extends StatelessWidget {
  const PopupMenuHomePage({
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
  final String name;
  final String url;
  final String duration;
  final String image;
  final bool done;
  final String dateTime;
  final List searchName;
  final String idAudio;
  final List collection;

  void _rename(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return SavePage(
            audioUrl: url,
            audioImage: image,
            audioDone: done,
            audioTime: dateTime,
            audioSearchName: searchName,
            audioCollection: collection,
            idAudio: idAudio,
            audioDuration: duration,
            audioName: name,
          );
        }),
      );
    });
  }

  void _addInCollections(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return CollectionAddAudioInCollection(
            collectionAudio: collection,
            idAudio: idAudio,
          );
        }),
      );
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
          Radius.circular(15.0),
        ),
      ),
      itemBuilder: (context) => [
        popupMenuItem(
          'Переименовать',
          () => _rename(context),
        ),
        popupMenuItem(
          'Добавить в подборку',
          () => _addInCollections(context),
        ),
        popupMenuItem(
          'Удалить ',
          () => AlertDialogApp.instance.alertDialog(
            context,
            idAudio,
            'DeleteCollections',
            'Collections',
          ),
        ),
        popupMenuItem(
          'Поделиться',
          () => AudioRepositories.instance.downloadAudio(
            idAudio,
            name,
          ),
        ),
      ],
    );
  }
}
