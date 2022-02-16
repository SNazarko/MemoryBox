import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/widgets/appbar_header_profile_edit.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/widgets/foto_container.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/widgets/list_podborok.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/widgets/sub_title.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/bottom_nav_bar.dart';

class PodborkiItemPage extends StatelessWidget {
  const PodborkiItemPage({
    Key? key,
  }) : super(key: key);
  static const rootName = '/podborki_item_page';

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWight = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    const AppbarHeaderProfileEdit(),
                    FotoContainer(),
                  ],
                ),
                SubTitle(),
                ListPodborokAudio(
                  screenHeight: screenHeight / 1.5,
                ),
              ],
            ),
            SizedBox(
              height: screenHeight,
              width: screenWight,
              child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 70.0),
                    child: PlayerPodborki(),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class PlayerPodborki extends StatelessWidget {
  const PlayerPodborki({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 80.0,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF8C84E2),
              Color(0xFF6C689F),
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          ),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: 60.0,
              height: 60.0,
              child: Image.asset(
                AppIcons.play_white,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Малышь Кокки 1',
                style: kTitle2TextStyle,
              ),
              const Text(
                '----------------------------------',
                style: kTitle2TextStyle,
              ),
              Row(
                children: const [
                  Text(
                    '00:00',
                    style: kTitle5TextStyle,
                  ),
                  SizedBox(
                    width: 140.0,
                  ),
                  Text(
                    '00:00',
                    style: kTitle5TextStyle,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Image.asset(AppIcons.next),
          )
        ]));
  }
}
