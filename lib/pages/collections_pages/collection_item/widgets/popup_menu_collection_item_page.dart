import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/collection_item_edit_page.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit_audio/collection_item_edit_audio.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/button/popup_menu_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../repositories/collections_repositories.dart';
import '../../collection/collection.dart';
import '../collections_item_page_model.dart';
import 'package:collection/collection.dart';

class PopupMenuCollectionItemPage extends StatelessWidget {
  PopupMenuCollectionItemPage({Key? key}) : super(key: key);
  final CollectionsRepositories _rep = CollectionsRepositories();
  List<String> idAudioList = [];
  List<String> nameList = [];

  Future<void> _getIdAudio(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(_rep.user!.phoneNumber!)
        .doc('id')
        .collection('Collections')
        .where('collections',
            arrayContains:
                Provider.of<CollectionsItemPageModel>(context, listen: false)
                    .getIdCollection)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        final String idAudio = result.data()['id'];
        final String name = result.data()['audioName'];
        idAudioList.add(idAudio);
        nameList.add(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_horiz,
        color: AppColor.white,
      ),
      iconSize: 40,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      itemBuilder: (_) => [
        popupMenuItem(
          'Редактировать',
          () {
            Timer(const Duration(seconds: 1), () {
              Navigator.pushNamed(context, CollectionItemEditPage.routeName);
            });
          },
        ),
        popupMenuItem(
          'Выбрать несколько',
          () {
            Timer(const Duration(seconds: 1), () {
              Navigator.pushNamed(context, CollectionItemEditAudio.routeName);
            });
          },
        ),
        popupMenuItem(
          'Удалить подборку',
          () {
            Timer(const Duration(seconds: 1), () {
              CollectionsRepositories().deleteCollection(
                Provider.of<CollectionsItemPageModel>(context, listen: false)
                    .getIdCollection,
                'CollectionsTale',
              );
              Navigator.pushNamed(context, Collections.routeName);
            });
          },
        ),
        popupMenuItem(
          'Поделиться',
          () async {
            await _getIdAudio(context);
            List<String> listFilePath = [];
            for (var item in IterableZip([idAudioList, nameList])) {
              final idAudio = item[0];
              final name = item[1];
              Directory directory = await getTemporaryDirectory();
              final filePath = directory.path + '/$name.mp3';
              listFilePath.add(filePath);
              try {
                await FirebaseStorage.instance
                    .ref('${_rep.user!.phoneNumber!}/userAudio/$idAudio.m4a')
                    .writeToFile(File(filePath));
              } on FirebaseException catch (e) {
                if (kDebugMode) {
                  print('Ошибка $e');
                }
              }
            }
            await Share.shareFiles(
              listFilePath,
              text:
                  Provider.of<CollectionsItemPageModel>(context, listen: false)
                      .getTitle,
              subject:
                  Provider.of<CollectionsItemPageModel>(context, listen: false)
                      .getSubTitle,
            );
          },
        ),
      ],
    );
  }
}
