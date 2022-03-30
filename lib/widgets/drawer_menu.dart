import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/view_model.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:provider/provider.dart';
import '../../resources/constants.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: Column(
                  children: const [
                    SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      'Аудиосказки',
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Меню',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: AppColor.colorText50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DrawerItem(
                      index: 0,
                      icon: Image.asset(
                        AppIcons.tabbar_home,
                        width: 20.0,
                        height: 20.0,
                      ),
                      title: 'Главная'),
                  _DrawerItem(
                      index: 4,
                      icon: Image.asset(
                        AppIcons.tabbar_profile,
                      ),
                      title: 'Профиль'),
                  _DrawerItem(
                      index: 1,
                      icon: Image.asset(
                        AppIcons.tabbar_category,
                      ),
                      title: 'Подборки'),
                  _DrawerItem(
                      index: 3,
                      icon: Image.asset(
                        AppIcons.tabbar_paper,
                      ),
                      title: 'Все аудеофайлы'),
                  _DrawerItem(
                      index: 6,
                      icon: Image.asset(
                        AppIcons.drawer_search,
                        width: 24.0,
                        height: 24.0,
                      ),
                      title: 'Поиск'),
                  _DrawerItem(
                      index: 5,
                      icon: Image.asset(
                        AppIcons.rec_delete,
                      ),
                      title: 'Недавно удальонные'),
                  const SizedBox(
                    height: 30,
                  ),
                  _DrawerItem(
                      index: 7,
                      icon: Image.asset(
                        AppIcons.drawer_wallet,
                        width: 24.0,
                        height: 24.0,
                      ),
                      title: 'Подписка'),
                  const SizedBox(
                    height: 5.0,
                  ),
                  _DrawerItem(
                      index: 7,
                      icon: Image.asset(
                        AppIcons.drawer_edit,
                        width: 24.0,
                        height: 24.0,
                      ),
                      title: 'Написать в \n поддержку'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final int index;
  final Widget icon;
  final String title;

  const _DrawerItem({
    Key? key,
    required this.index,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Navigation>();

    void _setIndex(int index) {
      model.setCurrentIndex = index;
    }

    return TextButton.icon(
      onPressed: () {
        _setIndex(index);
        Navigator.pop(context);
      },
      icon: icon,
      label: Text(title, style: kDraverTextStyle),
    );
  }
}
