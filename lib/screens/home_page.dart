import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/screens/screens_element/appbar_clipper.dart';
import 'package:memory_box/screens/screens_element/bottom_nav_bar.dart';
import '../constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
          BottomNavBar()
        ],
      ),
    );
  }
}

class _AppbarHeader extends StatelessWidget {
  const _AppbarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Stack(
        children: [
          Container(
            height: 350,
          ),
          ClipPath(
            clipper: AppbarClipper(),
            child: Container(
              color: kColorAppbar,
              width: double.infinity,
              height: 250,
            ),
          ),
          Positioned(
            left: 0,
            top: 30,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 70,
            child: Container(
              width: screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Подборки',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Открыть все',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 95,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 25,
                      ),
                      child: Text(
                        'Здесь будет твой набор сказок',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Добавить',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                width: screenWidth / 2.3,
                height: 210,
                decoration: const BoxDecoration(
                    color: Color(0xD971A59F),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    )),
              ),
            ),
          ),
          Positioned(
            top: 95,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 16),
              child: Container(
                child: const Center(
                  child: Text(
                    'Тут',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                width: screenWidth / 2.3,
                height: 95,
                decoration: const BoxDecoration(
                    color: Color(0xD9F1B488),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    )),
              ),
            ),
          ),
          Positioned(
            top: 200,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 24),
              child: Container(
                child: const Center(
                  child: Text(
                    'И тут',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                width: screenWidth / 2.3,
                height: 95,
                decoration: const BoxDecoration(
                    color: Color(0xD9678BD2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
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
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
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
                children: const [
                  Text(
                    'Аудиозаписи',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    'Открыть все',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 40),
              child: Text(
                'Как только ты запишешь аудио, она появится здесь.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Color(0x503A3A55)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
