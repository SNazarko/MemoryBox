import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/bottom_nav_bar.dart';
import 'package:memory_box/widgets/icon_back.dart';

class Podborki extends StatelessWidget {
  const Podborki({Key? key}) : super(key: key);
  static const rootName = 'podborki';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
        child: Stack(
          children: [
            _AppbarHeaderProfileEdit(),
            Padding(
              padding: const EdgeInsets.only(top: 90.0),
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20.0),
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                crossAxisCount: 2,
                childAspectRatio: 0.76,
                children: <Widget>[
                  PodborkiItem(),
                  PodborkiItem(),
                  PodborkiItem(),
                  PodborkiItem(),
                  PodborkiItem(),
                  PodborkiItem(),
                  PodborkiItem(),
                  PodborkiItem(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PodborkiItem extends StatelessWidget {
  PodborkiItem({
    Key? key,
  }) : super(key: key);
  String title = 'Сказаки ...';
  int quality = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185.0,
      height: 250.0,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: AppColor.white100,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '$quality часов',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: AppColor.white100,
                  ),
                ),
                const Text(
                  '3:33 часа',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: AppColor.white100,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _AppbarHeaderProfileEdit extends StatelessWidget {
  const _AppbarHeaderProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(),
        ClipPath(
          clipper: AppbarClipper(),
          child: Container(
            color: AppColor.colorAppbar2,
            width: double.infinity,
            height: 280.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  size: 35.0,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Подборки',
                style: kTitleTextStyle2,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  size: 35.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Все в одном месте',
                style: kTitle2TextStyle2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
