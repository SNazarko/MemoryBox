import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/home_page.dart';
import 'package:memory_box/pages/podborki_page/podborki.dart';
import 'package:memory_box/pages/profile_page/profile.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/pages/audio_recordings_page.dart';
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
            ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  HomePage.rootName,
                );
              },
              leading: Image.asset(
                AppIcons.tabbar_home,
                width: 20.0,
                height: 20.0,
              ),
              title: const Text('Главная', style: kDraverTextStyle),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Profile.rootName,
                );
              },
              leading: Image.asset(
                AppIcons.tabbar_profile,
              ),
              title: const Text(
                'Профиль',
                style: kDraverTextStyle,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Podborki.rootName,
                );
              },
              leading: Image.asset(
                AppIcons.tabbar_category,
              ),
              title: const Text(
                'Подборки',
                style: kDraverTextStyle,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AudioRecordingsPage.rootName,
                );
              },
              leading: Image.asset(
                AppIcons.tabbar_paper,
              ),
              title: const Text(
                'Все аудеофайлы',
                style: kDraverTextStyle,
              ),
            ),
            ListTile(
              leading: Image.asset(
                AppIcons.drawer_search,
                width: 24.0,
                height: 24.0,
              ),
              title: const Text(
                'Поиск',
                style: kDraverTextStyle,
              ),
            ),
            ListTile(
              leading: Image.asset(
                AppIcons.rec_delete,
              ),
              title: const Text(
                'Недавно удальонные',
                style: kDraverTextStyle,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              leading: Image.asset(
                AppIcons.drawer_wallet,
                width: 24.0,
                height: 24.0,
              ),
              title: const Text(
                'Подписка',
                style: kDraverTextStyle,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            ListTile(
              leading: Image.asset(
                AppIcons.drawer_edit,
                width: 24.0,
                height: 24.0,
              ),
              title: const Text(
                'Написать в \n поддержку',
                style: kDraverTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
