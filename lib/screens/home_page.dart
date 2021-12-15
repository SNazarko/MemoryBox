import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/screens/screens_element/appbar_clipper.dart';
import '../constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  height: 380,
                ),
                ClipPath(
                  clipper: AppbarClipper(),
                  child: Container(
                    color: kColorAppbar,
                    width: double.infinity,
                    height: 300,
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
                  top: 76,
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
                  top: 110,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Здесь будет твой набор сказок',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
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
                      height: 240,
                      decoration: const BoxDecoration(
                          color: Color(0xD971A59F),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          )),
                    ),
                  ),
                ),
                Positioned(
                  top: 110,
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
                      height: 110,
                      decoration: const BoxDecoration(
                          color: Color(0xD9F1B488),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          )),
                    ),
                  ),
                ),
                Positioned(
                  top: 230,
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
                      height: 110,
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
          ),
          Container(
            width: double.infinity,
            height: 65,
            decoration: BoxDecoration(
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
                ]),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                width: double.infinity,
                height: 65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _ItemBar(name: 'Главная', icon: 'images/tabbar_home.png'),
                    _ItemBar(
                        name: 'Подбарки', icon: 'images/tabbar_category.png'),
                    _ItemBar(
                        name: 'Запись', icon: 'images/tabbar_componen.png'),
                    _ItemBar(
                        name: 'Аудиозаписи', icon: 'images/tabbar_paper.png'),
                    _ItemBar(
                        name: 'Профиль', icon: 'images/tabbar_profile.png'),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class _ItemBar extends StatelessWidget {
  const _ItemBar({Key? key, required this.name, required this.icon})
      : super(key: key);
  final String name;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon),
        Text(
          name,
          style: kBottombarTextStyle,
        )
      ],
    );
  }
}
