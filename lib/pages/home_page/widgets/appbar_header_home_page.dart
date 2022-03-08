import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit_audio/collection_item_edit_audio.dart';
import 'package:memory_box/pages/delete_pages/delete_page.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';

import '../../save_page/save_page.dart';

class AppbarHeaderHomePage extends StatelessWidget {
  const AppbarHeaderHomePage({Key? key}) : super(key: key);
  final bool shouldPop = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Stack(
        children: [
          Container(
            height: screenHeight * 0.374,
          ),
          ClipPath(
            clipper: AppbarClipper(),
            child: Container(
              color: AppColor.colorAppbar,
              width: double.infinity,
              height: 200.0,
            ),
          ),
          _TitleAppbar(
            screenWidth: screenWidth,
          ),
          _GreenContainer(
            screenWidth: screenWidth,
          ),
          _OrangeContainer(
            screenWidth: screenWidth,
          ),
          _BlueContainer(
            screenWidth: screenWidth,
          )
        ],
      ),
    );
  }
}

class _TitleAppbar extends StatelessWidget {
  const _TitleAppbar({Key? key, required this.screenWidth}) : super(key: key);
  final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      child: SizedBox(
        width: screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Подборки',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, SavePage.routeName);
                },
                child: const Text(
                  'Открыть все',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GreenContainer extends StatelessWidget {
  const _GreenContainer({Key? key, required this.screenWidth})
      : super(key: key);
  final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: 25.0,
                ),
                child: Text(
                  'Здесь будет твой набор сказок',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40.0),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Добавить',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          width: screenWidth / 2.3,
          height: 210.0,
          decoration: const BoxDecoration(
              color: AppColor.green100,
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              )),
        ),
      ),
    );
  }
}

class _OrangeContainer extends StatelessWidget {
  const _OrangeContainer({Key? key, required this.screenWidth})
      : super(key: key);
  final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30.0,
      right: 0.0,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          right: 16.0,
        ),
        child: Container(
          child: const Center(
            child: Text(
              'Тут',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          width: screenWidth / 2.3,
          height: 95.0,
          decoration: const BoxDecoration(
              color: AppColor.yellow100,
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              )),
        ),
      ),
    );
  }
}

class _BlueContainer extends StatelessWidget {
  const _BlueContainer({Key? key, required this.screenWidth}) : super(key: key);
  final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 135.0,
      right: 0.0,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 16.0,
          top: 24.0,
        ),
        child: Container(
          child: const Center(
            child: Text(
              'И тут',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          width: screenWidth / 2.3,
          height: 95.0,
          decoration: const BoxDecoration(
              color: AppColor.blue200,
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              )),
        ),
      ),
    );
  }
}
