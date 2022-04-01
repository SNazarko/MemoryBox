import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/collection_item_edit_page.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit_audio/collection_item_edit_audio.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';
import 'package:provider/provider.dart';

import '../../../../repositories/collections_repositories.dart';
import '../../collection/collection.dart';
import '../collections_item_page_model.dart';
import 'appbar_header_profile_edit.dart';

class PopupMenuCollectionItemPage extends StatelessWidget {
  const PopupMenuCollectionItemPage({Key? key}) : super(key: key);

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
          () {},
        ),
      ],
    );
  }
}
