import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/widgets/appbar_header_profile_edit.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/widgets/foto_container.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/widgets/list_podborok.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/widgets/sub_title.dart';
import 'package:memory_box/widgets/bottom_nav_bar.dart';

class PodborkiItemPage extends StatelessWidget {
  const PodborkiItemPage({
    Key? key,
  }) : super(key: key);
  static const rootName = '/podborki_item_page';

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: SingleChildScrollView(
        child: Column(
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
              screenHeight: screenHeight / 2.4,
            ),
          ],
        ),
      ),
    );
  }
}
