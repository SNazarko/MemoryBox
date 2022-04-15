import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../../../repositories/collections_repositories.dart';
import '../../../repositories/user_repositories.dart';
import '../../../resources/app_colors.dart';
import '../../../widgets/popup_menu_button.dart';
import '../delete_page_model.dart';

class PopupMenuDeletePage extends StatelessWidget {
  PopupMenuDeletePage({Key? key}) : super(key: key);
  final CollectionsRepositories repositoriesCollections =
      CollectionsRepositories();
  final UserRepositories repositoriesUser = UserRepositories();
  List<String> idAudioList = [];
  List<int> sizeList = [];
  List<String> idAudioListAll = [];
  List<int> sizeListAll = [];

  Future<void> getIdCollection(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(repositoriesCollections.user!.phoneNumber!)
        .doc('id')
        .collection('DeleteCollections')
        .where('done', isEqualTo: true)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        final String idAudio = result.data()['id'];
        idAudioList.add(idAudio);
        final int size = result.data()['size'];
        sizeList.add(size);
      }
    });
  }

  Future<void> getIdCollectionAll(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(repositoriesCollections.user!.phoneNumber!)
        .doc('id')
        .collection('DeleteCollections')
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        final String idAudioAll = result.data()['id'];
        idAudioListAll.add(idAudioAll);
        final int size = result.data()['size'];
        sizeListAll.add(size);
      }
    });
  }

  Future<void> delete(BuildContext context) async {
    await getIdCollection(context);
    for (var item in IterableZip([idAudioList, sizeList])) {
      final idAudio = item[0];
      final sizeTemp = item[1];
      final size = sizeTemp as int;
      await repositoriesCollections.deleteCollection(
          '$idAudio', 'DeleteCollections');
      await repositoriesUser.updateSizeRepositories(-size);
    }
    await UserRepositories().updateTotalTimeQuality();
  }

  Future<void> reestablish(BuildContext context) async {
    await getIdCollection(context);
    for (var item in idAudioList) {
      await repositoriesCollections.copyPastCollections(
        item,
        'DeleteCollections',
        'Collections',
      );
      await repositoriesCollections.deleteCollection(item, 'DeleteCollections');
      await UserRepositories().updateTotalTimeQuality();
    }
  }

  Future<void> deleteAll(BuildContext context) async {
    await getIdCollection(context);
    for (var item in IterableZip([idAudioListAll, sizeListAll])) {
      final idAudio = item[0];
      final sizeTemp = item[1];
      final size = sizeTemp as int;
      await repositoriesCollections.deleteCollection(
          '$idAudio', 'DeleteCollections');
      await repositoriesUser.updateSizeRepositories(-size);
    }

    await UserRepositories().updateTotalTimeQuality();
  }

  Future<void> reestablishAll(BuildContext context) async {
    await getIdCollectionAll(context);
    for (var item in idAudioListAll) {
      await repositoriesCollections.copyPastCollections(
        item,
        'DeleteCollections',
        'Collections',
      );
      await repositoriesCollections.deleteCollection(item, 'DeleteCollections');
      await UserRepositories().updateTotalTimeQuality();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DeletePageModel>().getItemDone;
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
                    () => context.read<DeletePageModel>().stateCollections(),
                  ),
                  popupMenuItem(
                    'Удалить',
                    () => delete(context),
                  ),
                  popupMenuItem(
                    'Восстановить',
                    () => reestablish(context),
                  ),
                ]
            : (context) => [
                  popupMenuItem(
                    'Выбрать несколько',
                    () => context.read<DeletePageModel>().stateCollections(),
                  ),
                  popupMenuItem(
                    'Удалить все',
                    () => deleteAll(context),
                  ),
                  popupMenuItem(
                    'Восстановить все',
                    () => reestablishAll(context),
                  ),
                ]);
  }
}
