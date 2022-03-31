import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/user_model.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:memory_box/resources/app_icons.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../widgets/appbar_menu.dart';
import '../../widgets/button_continue.dart';
import '../../widgets/container_shadow.dart';

class SubscriptionPage extends StatelessWidget {
  SubscriptionPage({Key? key}) : super(key: key);
  static const routeName = '/subscription_page';
  final UserRepositories repositories = UserRepositories();

  Widget buildUser(UserModel model) => Subscription(
        onceAMonth: model.onceAMonth,
        onceAYear: model.onceAYear,
        onlyMonth: model.onlyMonth,
      );
  @override
  Widget build(BuildContext context) {
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
                StreamBuilder<List<UserModel>>(
                  stream: repositories.readUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    }
                    if (snapshot.hasData) {
                      final user = snapshot.data!;
                      return Container(
                        child: user.map(buildUser).toList().first,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Subscription extends StatelessWidget {
  Subscription(
      {Key? key,
      required this.onceAMonth,
      required this.onceAYear,
      required this.onlyMonth})
      : super(key: key);
  final UserRepositories repositories = UserRepositories();
  final bool? onceAMonth;
  final bool? onceAYear;
  final bool? onlyMonth;
  bool? done = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Positioned(
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
                child: Text('Выбери подписку', style: kBodiTextStyle),
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
                      children: [
                        const Text(
                          '300р',
                          style: TextStyle(
                            fontFamily: 'TTNorm',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w200,
                            color: AppColor.colorText,
                          ),
                        ),
                        const Text(
                          'в месяц',
                          style: TextStyle(
                            fontFamily: 'TTNorm',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w200,
                            color: AppColor.colorText,
                          ),
                        ),
                        DoneSubscriptionPage(
                          done: onceAMonth!,
                          onTap: () {
                            done = !done!;
                            if (done!) {
                              repositories.subscriptionDone('onceAMonth', true);
                              UserRepositories().subscription(31);
                            }
                            if (!done!) {
                              repositories.subscriptionDone(
                                  'onceAMonth', false);
                              UserRepositories().subscription(0);
                            }
                          },
                        ),
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
                      children: [
                        const Text(
                          '1800р',
                          style: TextStyle(
                            fontFamily: 'TTNorm',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w200,
                            color: AppColor.colorText,
                          ),
                        ),
                        const Text(
                          'в год',
                          style: TextStyle(
                            fontFamily: 'TTNorm',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w200,
                            color: AppColor.colorText,
                          ),
                        ),
                        DoneSubscriptionPage(
                          done: onceAYear!,
                          onTap: () {
                            done = !done!;
                            if (done!) {
                              repositories.subscriptionDone('onceAYear', true);
                              UserRepositories().subscription(365);
                            }
                            if (!done!) {
                              repositories.subscriptionDone('onceAYear', false);
                              UserRepositories().subscription(0);
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 30.0),
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
                          text: 'Возможность скачивать без ограничений'),
                    ],
                  ),
                ),
              ),
              onlyMonth!
                  ? const SizedBox()
                  : SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0, left: 10.0),
                        child: ButtonContinue(
                          onPressed: () {
                            repositories.subscriptionDone('onlyMonth', true);
                            UserRepositories().subscription(31);
                          },
                          text: 'Подписаться на месяц',
                        ),
                      ),
                    ),
            ],
          ),
        ));
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

class DoneSubscriptionPage extends StatelessWidget {
  const DoneSubscriptionPage({
    Key? key,
    this.onTap,
    required this.done,
  }) : super(key: key);
  final onTap;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: onTap,
        //     () {
        //   done = !done;
        //   setState(() {});
        // },
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
