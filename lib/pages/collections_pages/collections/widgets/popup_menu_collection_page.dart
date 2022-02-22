import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';

class PopupMenuCollectionPage extends StatelessWidget {
  const PopupMenuCollectionPage({Key? key}) : super(key: key);

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
          0
        ),
        popupMenuItem(
          'Выбрать несколько',
          () {},
          1
        ),
        popupMenuItem(
          'Удалить подборку',
          () {},
          2
        ),
        popupMenuItem(
          'Поделиться',
          () {},
          3
        ),
      ],
    );
  }
}
