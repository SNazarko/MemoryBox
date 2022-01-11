import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/resources/constants.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65.0,
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                offset: const Offset(0.0, 0.0),
                blurRadius: 10.0,
                spreadRadius: 1.0),
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ItemBar(
              name: 'Главная',
              icon: Image.asset(
                AppIcons.tabbar_home,
                width: 20.0,
                height: 20.0,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/HomePage',
                );
              },
            ),
            _ItemBar(
              name: 'Подбoрки',
              icon: Image.asset(AppIcons.tabbar_category),
            ),
            _ItemBar(
              name: 'Запись',
              icon: Image.asset(AppIcons.tabbar_componen),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/PlayPage',
                );
              },
            ),
            _ItemBar(
              name: 'Аудиозаписи',
              icon: Image.asset(AppIcons.tabbar_paper),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/AudioRecordingsPage',
                );
              },
            ),
            _ItemBar(
              name: 'Профиль',
              icon: Image.asset(AppIcons.tabbar_profile),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/Profile',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemBar extends StatelessWidget {
  const _ItemBar(
      {Key? key, required this.name, required this.icon, this.onPressed})
      : super(key: key);
  final String name;
  final Image icon;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: icon,
          padding: EdgeInsets.all(2.0),
          splashRadius: 40.0,
        ),
        Text(
          name,
          style: kBottombarTextStyle,
        ),
      ],
    );
  }
}
