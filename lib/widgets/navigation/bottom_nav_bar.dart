import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar(
      {Key? key, required this.currentTab, required this.onSelect})
      : super(key: key);
  final int currentTab;
  final void Function(int) onSelect;

  static const List<_BottomNavigationBarItem> _items = [
    _BottomNavigationBarItem(
      iconPath: AppIcons.tabbar_home,
      title: 'Главная',
    ),
    _BottomNavigationBarItem(
      iconPath: AppIcons.tabbar_category,
      title: 'Подбoрки',
    ),
    _BottomNavigationBarItem(
      iconPath: AppIcons.microfon,
      title: 'Запись',
    ),
    _BottomNavigationBarItem(
      iconPath: AppIcons.tabbar_paper,
      title: 'Аудиозаписи',
    ),
    _BottomNavigationBarItem(
      iconPath: AppIcons.tabbar_profile,
      title: 'Профиль',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kBottomNavigationBarHeight,
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
              spreadRadius: 1.0,
            ),
          ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
        ),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 3.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _items.map((e) {
                final int i = _items.indexOf(e);
                return Flexible(
                  child: SizedBox(
                    width: double.infinity,
                    height: kBottomNavigationBarHeight,
                    child: Material(
                      color: AppColor.white,
                      child: InkWell(
                        onTap: () => onSelect(i),
                        highlightColor: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 3.0,
                            ),
                            Flexible(
                              flex: 10,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                                child: e.iconPath == AppIcons.microfon
                                    ? Container(
                                        color: AppColor.pinkRec,
                                        child: Image.asset(
                                          e.iconPath,
                                          fit: BoxFit.fill,
                                          color: i == currentTab
                                              ? AppColor.pinkRec
                                              : AppColor.white,
                                        ),
                                      )
                                    : Container(
                                        color: null,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Image.asset(
                                            e.iconPath,
                                            fit: BoxFit.fill,
                                            color: i == currentTab
                                                ? AppColor.colorAppbar
                                                : AppColor.colorText80,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Flexible(
                              flex: 4,
                              child: Text(e.title,
                                  style: e.title == 'Запись'
                                      ? TextStyle(
                                          color: i == currentTab
                                              ? AppColor.white
                                              : AppColor.colorText80,
                                          fontSize: 11.0,
                                          height: 1.18,
                                        )
                                      : TextStyle(
                                          color: i == currentTab
                                              ? AppColor.colorAppbar
                                              : AppColor.colorText80,
                                          fontSize: 11.0,
                                          height: 1.18,
                                        )),
                            ),
                            const SizedBox(
                              height: 3.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavigationBarItem {
  const _BottomNavigationBarItem({
    required this.iconPath,
    required this.title,
  });

  final String iconPath;
  final String title;
}
