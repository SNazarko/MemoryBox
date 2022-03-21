import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';
import 'package:provider/provider.dart';
import '../../save_page/save_page.dart';
import '../../save_page/save_page_model.dart';

class PopupMenuAudioRecording extends StatelessWidget {
  const PopupMenuAudioRecording({
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
                  image: image ?? '',
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
