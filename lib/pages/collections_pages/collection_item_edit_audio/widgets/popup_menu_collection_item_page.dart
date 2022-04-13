import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import '../../../../repositories/collections_repositories.dart';
import '../../../../repositories/local_save_audiofile.dart';
import '../../collection_item/collections_item_page_model.dart';

class PopupMenuCollectionItemEditAudioPage extends StatelessWidget {
  PopupMenuCollectionItemEditAudioPage({Key? key}) : super(key: key);
  final CollectionsRepositories repositoriesCollections =
      CollectionsRepositories();
  List<String> idAudioList = [];
  List<String> nameList = [];
  List<List> collectionsList = [];

  Future<void> getIdAudio(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(repositoriesCollections.user!.phoneNumber!)
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
        final List collections = result.data()['collections'];
        idAudioList.add(idAudio);
        collectionsList.add(collections);
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
          'Отменить выбор',
          () async {
            await getIdAudio(context);
            for (var item in IterableZip([idAudioList, collectionsList])) {
              final idAudio = item[0];
              final collectionsTemp = item[1];
              final collections = collectionsTemp as List;
              await repositoriesCollections.addAudioCollections(
                  Provider.of<CollectionsItemPageModel>(context, listen: false)
                      .getIdCollection,
                  '$idAudio',
                  collections,
                  true);
            }
          },
        ),
        popupMenuItem(
          'Поделиться',
          () {},
        ),
        popupMenuItem(
          'Скачать все',
          () async {
            await getIdAudio(context);
            for (var item in IterableZip([idAudioList, nameList])) {
              final idAudio = item[0];
              final name = item[1];

              Directory? directory;
              var status = await Permission.storage.status;
              if (!status.isGranted) {
                await Permission.storage.request();
              }
              try {
                if (Platform.isIOS) {
                  directory =
                      await pathProvider.getApplicationDocumentsDirectory();
                } else {
                  directory = Directory('/storage/emulated/0/Download');
                  if (!await directory.exists()) {
                    directory =
                        await pathProvider.getExternalStorageDirectory();
                  }
                }
              } catch (err, stack) {
                print("Cannot get download folder path");
              }
              final filePath = directory!.path + '/$name.mp3';

              try {
                await FirebaseStorage.instance
                    .ref(
                        '${repositoriesCollections.user!.phoneNumber!}/userAudio/$idAudio.m4a')
                    .writeToFile(File(filePath));
              } on FirebaseException catch (e) {
                print('Ошибка $e');
              }
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  '$name.mp3',
                  style: const TextStyle(color: AppColor.colorText),
                ),
                backgroundColor: Colors.white,
              ));
            }
          },
        ),
        popupMenuItem(
          'Удалить все',
          () async {
            await getIdAudio(context);
            for (var item in IterableZip([idAudioList, collectionsList])) {
              final idAudio = item[0];
              final collectionsTemp = item[1];
              final collections = collectionsTemp as List;
              await repositoriesCollections.addAudioCollections(
                  Provider.of<CollectionsItemPageModel>(context, listen: false)
                      .getIdCollection,
                  '$idAudio',
                  collections,
                  false);
            }
          },
        ),
      ],
    );
  }
}
