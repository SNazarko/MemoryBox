import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit_audio/collection_item_edit_audio.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/widgets/player_mini/player_mini.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/alert_dialog.dart';
import '../../../save_page/save_page.dart';
import '../../../save_page/save_page_model.dart';
import '../collections_item_page_model.dart';

class ListCollectionsAudio extends StatelessWidget {
  ListCollectionsAudio({Key? key}) : super(key: key);
  final AudioRepositories repositories = AudioRepositories();

  Widget buildAudio(AudioModel audio) => PlayerMini(
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
        ),
      );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder<List<AudioModel>>(
        stream: repositories.readAudioSort(
            context.watch<CollectionsItemPageModel>().getIdCollection),
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
  _PopupMenuPlayerMini({
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
  }) : super(key: key);
  final AudioRepositories repositories = AudioRepositories();
  final CollectionsRepositories collectionsRepositories =
      CollectionsRepositories();
  final String name;
  final String url;
  final String duration;
  final String image;
  final String dateTime;
  final List searchName;
  final bool done;
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
                  image:
                      '${Provider.of<CollectionsItemPageModel>(context, listen: false).getPhoto}',
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
          () {
            Timer(const Duration(seconds: 1), () {
              Navigator.pushNamed(context, CollectionItemEditAudio.routeName);
            });
          },
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
            AudioRepositories().downloadAudio(idAudio, name);
          },
        ),
      ],
    );
  }
}
