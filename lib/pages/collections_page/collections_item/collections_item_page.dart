import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_page/collections_item/widgets/appbar_header_profile_edit.dart';
import 'package:memory_box/pages/collections_page/collections_item/widgets/foto_container.dart';
import 'package:memory_box/pages/collections_page/collections_item/widgets/list_collections.dart';
import 'package:memory_box/pages/collections_page/collections_item/widgets/player_collections.dart';
import 'package:memory_box/pages/collections_page/collections_item/widgets/sub_title.dart';

class CollectionsItemPage extends StatelessWidget {
  const CollectionsItemPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/collections_item_page';
  static Widget create() {
    return const CollectionsItemPage();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWight = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: const [
                    AppbarHeaderProfileEdit(),
                    PhotoContainer(),
                  ],
                ),
                const SubTitle(),
                ListCollectionsAudio(
                  screenHeight: screenHeight * 0.66,
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.9,
              width: screenWight,
              child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 0.0),
                    child: PlayerCollections(),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
