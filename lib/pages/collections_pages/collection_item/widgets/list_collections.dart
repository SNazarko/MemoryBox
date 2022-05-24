import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit_audio/collection_item_edit_audio.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/widgets/button/popup_menu_button.dart';

import '../../../../blocs/list_item_bloc/list_item_bloc.dart';
import '../../../../resources/app_colors.dart';
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<ListItemBloc, ListItemState>(
        builder: (context, state) {
          if (state.status == ListItemStatus.emptyList) {
            return const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
              ),
              child: Center(
                child: Text(
                  'Как только ты добавиш аудио, оно появится здесь.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: AppColor.colorText50,
                  ),
                ),
              ),
            );
          }
          if (state.status == ListItemStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == ListItemStatus.success) {
            return ListView.builder(
              padding: const EdgeInsets.only(
                bottom: 95.0,
              ),
              itemCount: state.list.length,
              itemBuilder: (BuildContext context, int index) {
                final audio = state.list[index];
                return PlayerMini(
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
              },
            );
          }
          if (state.status == ListItemStatus.failed) {
            return const Center(
              child: Text('Ой: сталася помилка!'),
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
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
      iconSize: 40.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      itemBuilder: (context) => [
        popupMenuItem(
          'Переименовать',
          () => _rename(
            context,
            imageCollection,
          ),
        ),
        popupMenuItem(
          'Добавить в подборку',
          () => Timer(const Duration(seconds: 1), () {
            Navigator.pushNamed(
              context,
              CollectionItemEditAudio.routeName,
            );
          }),
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
