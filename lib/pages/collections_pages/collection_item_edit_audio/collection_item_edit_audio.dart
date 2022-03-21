import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_item/widgets/photo_container.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit_audio/widgets/appbar_header_collection_item_edit_audio.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit_audio/widgets/list_collection_item_edit_audio.dart';

class CollectionItemEditAudio extends StatelessWidget {
  const CollectionItemEditAudio({
    Key? key,
  }) : super(key: key);
  static const routeName = '/collection_item_edit_audio';
  static Widget create() {
    return const CollectionItemEditAudio();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
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
                        AppbarHeaderCollectionItemEditAudio(),
                        const PhotoContainer(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListCollectionItemEditAudio(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
