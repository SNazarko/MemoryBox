import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../repositories/collections_repositories.dart';
import '../../collection_item/collections_item_page_model.dart';
import '../collection_model.dart';
import 'package:collection/collection.dart';

class PopupMenuCollectionPage extends StatelessWidget {
  PopupMenuCollectionPage({Key? key}) : super(key: key);
  final List<String> _idCollectionsList = [];

  final CollectionsRepositories _repositoriesCollections =
      CollectionsRepositories();
  final List<String> _idAudioList = [];
  final List<String> _nameList = [];

  Future<void> _getIdAudio(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(_repositoriesCollections.user!.phoneNumber!)
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
        _idAudioList.add(idAudio);
        _nameList.add(name);
      }
    });
  }

  Future<void> _getIdCollection(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(_repositoriesCollections.user!.phoneNumber!)
        .doc('id')
        .collection('CollectionsTale')
        .where('doneCollection', isEqualTo: true)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        final String idCollections = result.data()['id'];
        _idCollectionsList.add(idCollections);
      }
    });
  }

  Future<void> _deleteCollections(BuildContext context) async {
    await _getIdCollection(context);
    for (var item in _idCollectionsList) {
      await CollectionsRepositories().deleteCollection(
        item,
        'CollectionsTale',
      );
    }
  }

  Future<void> _shareCollections(BuildContext context) async {
    await _getIdAudio(context);
    List<String> listFilePath = [];
    for (var item in IterableZip([_idAudioList, _nameList])) {
      final idAudio = item[0];
      final name = item[1];
      Directory directory = await getTemporaryDirectory();
      final filePath = directory.path + '/$name.mp3';
      listFilePath.add(filePath);
      try {
        await FirebaseStorage.instance
            .ref(
                '${_repositoriesCollections.user!.phoneNumber!}/userAudio/$idAudio.m4a')
            .writeToFile(File(filePath));
      } on FirebaseException catch (e) {
        if (kDebugMode) {
          print('Ошибка $e');
        }
      }
    }
    await Share.shareFiles(
      listFilePath,
      text: Provider.of<CollectionsItemPageModel>(context, listen: false)
          .getTitle,
      subject: Provider.of<CollectionsItemPageModel>(context, listen: false)
          .getSubTitle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CollectionModel>().getItemDone;
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
        itemBuilder: state
            ? (context) => [
                  popupMenuItem('Снять выделение',
                      () => context.read<CollectionModel>().stateCollections()),
                  popupMenuItem(
                    'Удалить подборку',
                    () => _deleteCollections(context),
                  ),
                  popupMenuItem(
                    'Поделиться',
                    () => _shareCollections(context),
                  ),
                ]
            : (context) => [
                  popupMenuItem(
                    'Выбрать несколько',
                    () => context.read<CollectionModel>().stateCollections(),
                  ),
                ]);
  }
}
