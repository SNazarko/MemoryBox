import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/user_model.dart';
import 'package:memory_box/resources/app_icons.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../widgets/appbar_menu.dart';
import '../../widgets/button_continue.dart';
import '../../widgets/container_shadow.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({Key? key}) : super(key: key);
  static const routeName = '/subscription_page';

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Text(
          'Подписка',
          style: kTitleTextStyle2,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                const AppbarMenu(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Расширь возможности',
                      style: kTitle2TextStyle2,
                    ),
                  ],
                ),
                Positioned(
                    left: 5.0,
                    top: 60.0,
                    child: Container(
                      height: 550.0,
                      width: screenWidth * 0.975,
                      decoration: kBorderContainer2,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 25.0, bottom: 20.0),
                            child:
                                Text('Выбери подписку', style: kBodiTextStyle),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ContainerShadow(
                                width: screenWidth * 0.42,
                                height: 175.0,
                                radius: 20.0,
                                widget: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '300р',
                                      style: TextStyle(
                                        fontFamily: 'TTNorm',
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w200,
                                        color: AppColor.colorText,
                                      ),
                                    ),
                                    Text(
                                      'в месяц',
                                      style: TextStyle(
                                        fontFamily: 'TTNorm',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w200,
                                        color: AppColor.colorText,
                                      ),
                                    ),
                                    DoneSubscriptionPage(),
                                  ],
                                ),
                                image: Text(''),
                              ),
                              ContainerShadow(
                                width: screenWidth * 0.42,
                                height: 175.0,
                                image: Text(''),
                                radius: 20.0,
                                widget: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '1800р',
                                      style: TextStyle(
                                        fontFamily: 'TTNorm',
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w200,
                                        color: AppColor.colorText,
                                      ),
                                    ),
                                    Text(
                                      'в год',
                                      style: TextStyle(
                                        fontFamily: 'TTNorm',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w200,
                                        color: AppColor.colorText,
                                      ),
                                    ),
                                    DoneSubscriptionPage()
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, left: 30.0),
                            child: SizedBox(
                              height: 120.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Что дает подписка:',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: AppColor.colorText,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  _Link(
                                      image: AppIcons.subscription_infinity,
                                      text: 'Неограниченая память'),
                                  _Link(
                                      image: AppIcons.subscription_upload,
                                      text: 'Все файлы хранятся в облаке'),
                                  _Link(
                                      image: AppIcons.subscription_download,
                                      text:
                                          'Возможность скачивать без ограничений'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            child: Padding(
                              padding: EdgeInsets.only(top: 25.0, left: 10.0),
                              child: ButtonContinue(
                                // onPressed: (){
                                //   print();
                                // },
                                text: 'Подписаться на месяц',
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Link extends StatelessWidget {
  const _Link({Key? key, required this.image, required this.text})
      : super(key: key);
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 20.0,
            height: 20.0,
          ),
          const SizedBox(
            width: 12.0,
          ),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'TTNorm',
              fontSize: 14.0,
              fontWeight: FontWeight.w200,
              color: AppColor.colorText,
            ),
          )
        ],
      ),
    );
  }
}

class DoneSubscriptionPage extends StatefulWidget {
  const DoneSubscriptionPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DoneSubscriptionPage> createState() => _DoneSubscriptionPageState();
}

class _DoneSubscriptionPageState extends State<DoneSubscriptionPage> {
  bool done = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          done = !done;
          setState(() {});
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.colorText),
            borderRadius: const BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
          child: Center(
            child: Icon(
              Icons.done,
              color: done ? AppColor.colorText : AppColor.white,
            ),
          ),
        ),
      ),
    );
  }
}
