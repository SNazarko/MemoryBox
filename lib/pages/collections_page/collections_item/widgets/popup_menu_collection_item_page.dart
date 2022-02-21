import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        popupMenuItem(
          'Редактировать',
          () {},
        ),
        popupMenuItem(
          'Выбрать несколько',
          () {},
        ),
        popupMenuItem(
          'Удалить подборку',
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
