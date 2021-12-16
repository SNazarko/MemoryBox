import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  BoxDecoration boxDecoration() {
    return BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0.0, 0.0),
            blurRadius: 10.0,
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: boxDecoration(),
      child: Container(
          decoration: kBorderContainer2,
          width: double.infinity,
          height: 65,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ItemBar(
                  name: 'Главная',
                  icon: 'tabbar_home.png',
                ),
                _ItemBar(
                  name: 'Подбoрки',
                  icon: 'tabbar_category.png',
                ),
                _ItemBar(
                  name: 'Запись',
                  icon: 'tabbar_componen.png',
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/PlayPage',
                    );
                  },
                ),
                _ItemBar(
                  name: 'Аудиозаписи',
                  icon: 'tabbar_paper.png',
                ),
                _ItemBar(
                  name: 'Профиль',
                  icon: 'tabbar_profile.png',
                ),
              ],
            ),
          )),
    );
  }
}

class _ItemBar extends StatelessWidget {
  const _ItemBar(
      {Key? key, required this.name, required this.icon, this.onPressed})
      : super(key: key);
  final String name;
  final String icon;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Image.asset('images/$icon'),
          padding: EdgeInsets.all(2),
          splashRadius: 40,
        ),
        Text(
          name,
          style: kBottombarTextStyle,
        ),
      ],
    );
  }
}
