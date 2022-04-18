import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/view_model.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:provider/provider.dart';

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
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 3.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _ButtonItem(
              title: 'Главная',
              icon: AppIcons.tabbar_home,
              index: 0,
            ),
            _ButtonItem(
              title: 'Подбoрки',
              icon: AppIcons.tabbar_category,
              index: 1,
            ),
            _RecordItem(),
            _ButtonItem(
              title: 'Аудиозаписи',
              icon: AppIcons.tabbar_paper,
              index: 3,
            ),
            _ButtonItem(
              title: 'Профиль',
              icon: AppIcons.tabbar_profile,
              index: 4,
            )
          ],
        ),
      ),
    );
  }
}

class _ButtonItem extends StatelessWidget {
  final String title;
  final String icon;
  final int index;
  const _ButtonItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Navigation>();

    void _setIndex(int index) {
      model.setCurrentIndex = index;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            icon: Image.asset(
              icon,
              color: model.currentIndex == index
                  ? AppColor.colorAppbar
                  : Colors.black,
            ),
            onPressed: () {
              _setIndex(index);
            }),
        Text(title,
            style: kBottombarTextStyle.copyWith(
              color: model.currentIndex == index
                  ? AppColor.colorAppbar
                  : Colors.black,
            ))
      ],
    );
  }
}

class _RecordItem extends StatelessWidget {
  const _RecordItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Navigation>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22), color: AppColor.pinkRec),
          child: GestureDetector(
            onTap: () {
              model.setCurrentIndex = 2;
            },
            child: Image.asset(
              AppIcons.microfon,
              width: 35,
              height: 35,
              color: model.currentIndex != 2 ? Colors.white : AppColor.pinkRec,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Запись',
          style: kBottombarTextStyle.copyWith(
              color: model.currentIndex != 2 ? AppColor.pinkRec : Colors.white),
        )
      ],
    );
  }
}
