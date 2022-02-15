import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/widgets/appbar_header_profile_edit.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/widgets/foto_container.dart';
import 'package:memory_box/widgets/bottom_nav_bar.dart';

import '../../test.dart';

class PodborkiItem extends StatelessWidget {
  PodborkiItem({Key? key}) : super(key: key);
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
            ListPodborok(
              screenHeight: screenHeight / 2.4,
            ),
          ],
        ),
      ),
    );
  }
}
