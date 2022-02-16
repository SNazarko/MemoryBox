import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/widgets/appbar_header_profile_edit.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/widgets/foto_container.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/widgets/list_podborok.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/widgets/player_podborki.dart';
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
