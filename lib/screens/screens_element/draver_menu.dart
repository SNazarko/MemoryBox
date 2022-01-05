import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class DraverMenu extends StatelessWidget {
  const DraverMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
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
                      height: 40,
                    ),
                    Text(
                      'Аудиосказки',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Меню',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0X503A3A55),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                'images/tabbar_home.png',
                width: 20,
                height: 20,
              ),
              title: const Text(
                'Главная',
                style: TextStyle(
                  fontSize: 18,
                  color: kColorText,
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                'images/tabbar_profile.png',
              ),
              title: const Text(
                'Профиль',
                style: TextStyle(
                  fontSize: 18,
                  color: kColorText,
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                'images/tabbar_category.png',
              ),
              title: const Text(
                'Подборки',
                style: TextStyle(
                  fontSize: 18,
                  color: kColorText,
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                'images/tabbar_paper.png',
              ),
              title: const Text(
                'Все аудеофайлы',
                style: TextStyle(
                  fontSize: 18,
                  color: kColorText,
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                'images/drawer_search.png',
                width: 24.0,
                height: 24.0,
              ),
              title: const Text(
                'Поиск',
                style: TextStyle(
                  fontSize: 18,
                  color: kColorText,
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                'images/rec_delete.png',
              ),
              title: const Text(
                'Недавно удальонные',
                style: TextStyle(
                  fontSize: 18,
                  color: kColorText,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              leading: Image.asset(
                'images/drawer_wallet.png',
                width: 24.0,
                height: 24.0,
              ),
              title: const Text(
                'Подписка',
                style: TextStyle(
                  fontSize: 18,
                  color: kColorText,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ListTile(
              leading: Image.asset(
                'images/drawer_edit.png',
                width: 24.0,
                height: 24.0,
              ),
              title: const Text(
                'Написать в \n поддержку',
                style: TextStyle(
                  fontSize: 18,
                  color: kColorText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
