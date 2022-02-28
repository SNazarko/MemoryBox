import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';

class PopupMenuHomePage extends StatelessWidget {
  const PopupMenuHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_horiz,
      ),
      iconSize: 40,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      itemBuilder: (context) => [
        popupMenuItem('Переименовать', () {}, 0),
        popupMenuItem('Добавить в подборку', () {}, 1),
        popupMenuItem('Удалить ', () {}, 2),
        popupMenuItem('Поделиться', () {}, 3),
      ],
    );
  }
}