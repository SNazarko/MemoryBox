import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memory_box/widgets/button/alert_dialog.dart';
import 'package:memory_box/widgets/button/popup_menu_button.dart';
import 'package:provider/provider.dart';
import '../../../repositories/audio_repositories.dart';
import '../../collections_pages/collection_add_audio_in_collection/collection_add_audio_in_collection.dart';
import '../../collections_pages/collection_add_audio_in_collection/collection_add_audio_in_collection_model.dart';
import '../../save_page/save_page.dart';
import '../../save_page/save_page_model.dart';

class PopupMenuAudioRecording extends StatelessWidget {
  PopupMenuAudioRecording({
    Key? key,
    this.image,
    required this.url,
    required this.duration,
    required this.name,
    required this.done,
    required this.dateTime,
    required this.searchName,
    required this.idAudio,
    required this.collection,
  }) : super(key: key);
  final String? image;
  final String url;
  final String duration;
  final String name;
  final bool done;
  final String dateTime;
  final List searchName;
  final String idAudio;
  final List collection;
  final AudioRepositories _repositoriesAudio = AudioRepositories();

  void _rename(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SavePage(
          audioUrl: url,
          audioImage: image ?? '',
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

  void _addInCollection(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CollectionAddAudioInCollection(
          collectionAudio: collection,
          idAudio: idAudio,
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
        popupMenuItem('??????????????????????????', () => _rename(context)),
        popupMenuItem(
          '???????????????? ?? ????????????????',
          () => _addInCollection(context),
        ),
        popupMenuItem(
          '?????????????? ',
          () => AlertDialogApp().alertDialog(
            context,
            idAudio,
            'DeleteCollections',
            'Collections',
          ),
        ),
        popupMenuItem(
          '????????????????????',
          () => _repositoriesAudio.downloadAudio(idAudio, name),
        ),
      ],
    );
  }
}
