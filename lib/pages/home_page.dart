import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/authorization_page/first_authorization_page.dart';
import 'package:memory_box/pages/logo_page/screensaver_page.dart';
import 'package:memory_box/pages/recordings_page/record_page.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/bottom_nav_bar.dart';
import 'package:memory_box/widgets/drawer_menu.dart';
import '../resources/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const rootName = '/home_page';

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      drawer: DrawerMenu(),
      bottomNavigationBar: BottomNavBar(),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _AppbarHeader(),
                _MenuSound(
                  screenHeight: screenHeight / 2.4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppbarHeader extends StatelessWidget {
  const _AppbarHeader({Key? key}) : super(key: key);
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
          Positioned(
            top: 0.0,
            child: Container(
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
                        Navigator.pushNamed(context, RecordPage.rootName);
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
          ),
          Positioned(
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
          ),
          Positioned(
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
          ),
          Positioned(
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
          ),
        ],
      ),
    );
  }
}

class _MenuSound extends StatelessWidget {
  _MenuSound({Key? key, required this.screenHeight}) : super(key: key);
  final double screenHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0.0, -5.0),
              blurRadius: 10.0,
            )
          ]),
      child: Container(
        width: double.infinity,
        height: screenHeight,
        decoration: kBorderContainer2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Аудиозаписи',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Screensaver.rootName);
                    },
                    child: const Text(
                      'Открыть все',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 50.0,
                horizontal: 40.0,
              ),
              child: Text(
                'Как только ты запишешь аудио, она появится здесь.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: AppColor.colorText50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
