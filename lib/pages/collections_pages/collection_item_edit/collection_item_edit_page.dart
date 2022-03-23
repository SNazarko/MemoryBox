import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/widgets/appbar_header_collection_item_edit.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/widgets/list_collections_audio_item_edit.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/widgets/photo_container.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/widgets/sub_title_collection_item_edit.dart';

class CollectionItemEditPage extends StatelessWidget {
  const CollectionItemEditPage({Key? key}) : super(key: key);
  static const routeName = '/collection_item_edit_page.dart';
  static Widget create() {
    return const CollectionItemEditPage();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: const [
                    AppbarHeaderCollectionItemEdit(),
                    PhotoContainer(),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15.0,
                      ),
                      const SubTitleCollectionItemEdit(),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: ListCollectionsAudioItemEdit(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
