import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_edit/widgets/appbar_header_edit.dart';
import 'package:memory_box/pages/collections_pages/collection_edit/widgets/button_add_audio.dart';
import 'package:memory_box/pages/collections_pages/collection_edit/widgets/photo_container.dart';
import 'package:memory_box/pages/collections_pages/collection_edit/widgets/subtitle_collection_edit.dart';

class CollectionsEdit extends StatelessWidget {
  const CollectionsEdit({Key? key}) : super(key: key);
  static const routeName = 'collection_edit';
  static Widget create() {
    return const CollectionsEdit();
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
                    AppbarHeaderEdit(),
                    PhotoContainer(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SubTitleCollectionEdit(),
                    ButtonAddAudio(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
