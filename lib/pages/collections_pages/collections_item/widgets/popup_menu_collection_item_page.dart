import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/collection_item_edit_page.dart';
import 'package:memory_box/pages/home_page.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';

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
      itemBuilder: (context) => [
        popupMenuItem('Редактировать', () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const CollectionItemEditPage();
          }));
        }, 0),
        popupMenuItem('Выбрать несколько', () {}, 1),
        popupMenuItem('Удалить подборку', () {
          Navigator.pushNamed(context, HomePage.routeName);
        }, 2),
        popupMenuItem('Поделиться', () {}, 3),
      ],
    );
  }
}
