import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../../../repositories/collections_repositories.dart';
import '../../../repositories/user_repositories.dart';
import '../../../resources/app_colors.dart';
import '../../../widgets/button/popup_menu_button.dart';
import '../delete_page_model.dart';

class PopupMenuDeletePage extends StatelessWidget {
  PopupMenuDeletePage({Key? key}) : super(key: key);
  final CollectionsRepositories _rep = CollectionsRepositories();
  final UserRepositories repositoriesUser = UserRepositories();
  final List<String> _idAudioList = [];
  final List<int> _sizeList = [];
  final List<String> _idAudioListAll = [];
  final List<int> _sizeListAll = [];

  Future<void> _getIdCollection(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(_rep.user!.phoneNumber!)
        .doc('id')
        .collection('DeleteCollections')
        .where('done', isEqualTo: true)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        final String idAudio = result.data()['id'];
        _idAudioList.add(idAudio);
        final int size = result.data()['size'];
        _sizeList.add(size);
      }
    });
  }

  Future<void> _getIdCollectionAll(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(_rep.user!.phoneNumber!)
        .doc('id')
        .collection('DeleteCollections')
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        final String idAudioAll = result.data()['id'];
        _idAudioListAll.add(idAudioAll);
        final int size = result.data()['size'];
        _sizeListAll.add(size);
      }
    });
  }

  Future<void> _delete(BuildContext context) async {
    await _getIdCollection(context);
    for (var item in IterableZip([_idAudioList, _sizeList])) {
      final idAudio = item[0];
      final sizeTemp = item[1];
      final size = sizeTemp as int;
      await _rep.deleteCollectionApp('$idAudio', 'DeleteCollections');
      await repositoriesUser.updateSizeRepositories(-size);
    }
    await UserRepositories().updateTotalTimeQuality();
  }

  Future<void> _reestablish(BuildContext context) async {
    await _getIdCollection(context);
    for (var item in _idAudioList) {
      await _rep.copyPastCollections(
        item,
        'DeleteCollections',
        'Collections',
      );
      await _rep.deleteCollection(item, 'DeleteCollections');
      await UserRepositories().updateTotalTimeQuality();
    }
  }

  Future<void> _deleteAll(BuildContext context) async {
    await _getIdCollectionAll(context);
    for (var item in IterableZip([_idAudioListAll, _sizeListAll])) {
      final idAudio = item[0];
      final sizeTemp = item[1];
      final size = sizeTemp as int;
      await _rep.deleteCollectionApp('$idAudio', 'DeleteCollections');
      await repositoriesUser.updateSizeRepositories(-size);
    }

    await UserRepositories().updateTotalTimeQuality();
  }

  Future<void> _reestablishAll(BuildContext context) async {
    await _getIdCollectionAll(context);
    for (var item in _idAudioListAll) {
      await _rep.copyPastCollections(
        item,
        'DeleteCollections',
        'Collections',
      );
      await _rep.deleteCollection(item, 'DeleteCollections');
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
                    '?????????? ??????????????????',
                    () => context.read<DeletePageModel>().stateCollections(),
                  ),
                  popupMenuItem(
                    '??????????????',
                    () => _delete(context),
                  ),
                  popupMenuItem(
                    '????????????????????????',
                    () => _reestablish(context),
                  ),
                ]
            : (context) => [
                  popupMenuItem(
                    '?????????????? ??????????????????',
                    () => context.read<DeletePageModel>().stateCollections(),
                  ),
                  popupMenuItem(
                    '?????????????? ??????',
                    () => _deleteAll(context),
                  ),
                  popupMenuItem(
                    '???????????????????????? ??????',
                    () => _reestablishAll(context),
                  ),
                ]);
  }
}
