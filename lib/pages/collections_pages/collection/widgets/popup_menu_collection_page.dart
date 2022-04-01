import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';
import 'package:provider/provider.dart';

import '../../../../repositories/collections_repositories.dart';
import '../collection_model.dart';

class PopupMenuCollectionPage extends StatelessWidget {
  PopupMenuCollectionPage({Key? key}) : super(key: key);
  List<String> idCollectionsList = [];
  Future<void> getIdCollection(BuildContext context) async {
    final CollectionsRepositories repositoriesCollections =
        CollectionsRepositories();

    await FirebaseFirestore.instance
        .collection(repositoriesCollections.user!.phoneNumber!)
        .doc('id')
        .collection('CollectionsTale')
        .where('doneCollection', isEqualTo: true)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        final String idCollections = result.data()['id'];
        idCollectionsList.add(idCollections);
      }
    });
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
                  popupMenuItem(
                    'Снять выделение',
                    () {
                      context.read<CollectionModel>().stateCollections();
                    },
                  ),
                  popupMenuItem(
                    'Удалить подборку',
                    () async {
                      await getIdCollection(context);
                      for (var item in idCollectionsList) {
                        await CollectionsRepositories().deleteCollection(
                          item,
                          'CollectionsTale',
                        );
                      }

                      // const CollectionItem().alertDialog(context);
                    },
                  ),
                  popupMenuItem(
                    'Поделиться',
                    () {},
                  ),
                ]
            : (context) => [
                  popupMenuItem(
                    'Выбрать несколько',
                    () {
                      context.read<CollectionModel>().stateCollections();
                    },
                  ),
                ]);
  }
}
