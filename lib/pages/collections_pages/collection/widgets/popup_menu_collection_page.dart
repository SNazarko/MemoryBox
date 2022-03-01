import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';
import 'package:provider/provider.dart';

import '../collection_model.dart';
import 'collection_item.dart';

class PopupMenuCollectionPage extends StatelessWidget {
  const PopupMenuCollectionPage({Key? key}) : super(key: key);

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
                  popupMenuItem('Снять выделение', () {
                    context.read<CollectionModel>().stateCollections();
                  }, 1),
                  popupMenuItem('Удалить подборку', () {
                    const CollectionItem().alertDialog(context);
                  }, 2),
                  popupMenuItem('Поделиться', () {}, 3),
                ]
            : (context) => [
                  popupMenuItem('Выбрать несколько', () {
                    context.read<CollectionModel>().stateCollections();
                  }, 1),
                ]);
  }
}
