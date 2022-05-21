import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/save_page/save_page.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/widgets/button/popup_menu_button.dart';
import '../../../widgets/button/alert_dialog.dart';
import '../../../widgets/player/player_mini/player_mini.dart';
import '../../collections_pages/collection_add_audio_in_collection/collection_add_audio_in_collection.dart';
import '../bloc/search_page/search_page_bloc.dart';

class ListPlayersSearchPage extends StatelessWidget {
  const ListPlayersSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.95,
          child: BlocBuilder<SearchPageBloc, SearchPageState>(
            builder: (context, state) {
              if (state.status == SearchPageStatus.initial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == SearchPageStatus.success) {
                return ListView.builder(
                  padding: const EdgeInsets.only(
                    top: 165.0,
                    bottom: 110.0,
                  ),
                  itemCount: state.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final audio = state.list[index];
                    return PlayerMini(
                      duration: '${audio.duration}',
                      url: '${audio.audioUrl}',
                      name: '${audio.audioName}',
                      done: audio.done!,
                      id: '${audio.id}',
                      collection: audio.collections ?? [],
                      popupMenu: _PopupMenuAudioSearchPage(
                        url: '${audio.audioUrl}',
                        duration: '${audio.duration}',
                        name: '${audio.audioName}',
                        image: '',
                        searchName: audio.searchName ?? [],
                        dateTime: audio.dateTime!,
                        collection: audio.collections ?? [],
                        idAudio: audio.id!,
                        done: audio.done ?? false,
                      ),
                    );
                  },
                );
              }
              if (state.status == SearchPageStatus.failed) {
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
        ),
      ],
    );
  }
}

class _PopupMenuAudioSearchPage extends StatelessWidget {
  const _PopupMenuAudioSearchPage({
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
  final String image;
  final String url;
  final String duration;
  final String name;
  final bool done;
  final String dateTime;
  final List searchName;
  final String idAudio;
  final List collection;

  void _rename(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
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
      }));
    });
  }

  void _addInCollection(BuildContext context) {
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
      iconSize: 40.0,
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
          () => _addInCollection(context),
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
