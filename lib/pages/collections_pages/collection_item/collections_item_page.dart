import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_item/widgets/appbar_header_profile_edit.dart';
import 'package:memory_box/pages/collections_pages/collection_item/widgets/photo_container.dart';
import 'package:memory_box/pages/collections_pages/collection_item/widgets/list_collections.dart';
import 'package:memory_box/pages/collections_pages/collection_item/widgets/sub_title.dart';
import 'package:provider/provider.dart';

import '../../../widgets/player/player_collections/player_collections.dart';
import 'collections_item_page_model.dart';

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
        child: SizedBox(
          height: screenHeight,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        AppbarHeaderCollectionItem(),
                        const PhotoContainer(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const SubTitle(),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: ListCollectionsAudio(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              PlayerCollections(
                screenWight: screenWight,
                screenHeight: screenHeight,
                idCollection: Provider.of<CollectionsItemPageModel>(context,
                        listen: false)
                    .getIdCollection,
                animation: context.watch<CollectionsItemPageModel>().getAnim,
              )
            ],
          ),
        ),
      ),
    );
  }
}
