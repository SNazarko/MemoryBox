import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/widgets/appbar_header_collection_item_edit.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/widgets/list_collections_audio_item_edit.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/widgets/photo_container.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/widgets/sub_title_collection_item_edit.dart';
import 'package:provider/provider.dart';

import 'collection_item_edit_page_model.dart';

class CollectionItemEditPageArguments {
  CollectionItemEditPageArguments(
    this.idCollection,
    this.titleCollection,
    this.subTitleCollection,
    this.qualityCollection,
    this.imageCollection,
    this.dataCollection,
    this.totalTimeCollection,
  );
  final String idCollection;
  final String titleCollection;
  final String subTitleCollection;
  final String qualityCollection;
  final String imageCollection;
  final String dataCollection;
  final String totalTimeCollection;
}

class CollectionItemEditPage extends StatelessWidget {
  const CollectionItemEditPage(
      {Key? key,
      required this.idCollection,
      required this.titleCollection,
      required this.subTitleCollection,
      required this.qualityCollection,
      required this.imageCollection,
      required this.dataCollection,
      required this.totalTimeCollection})
      : super(key: key);
  static const routeName = '/collection_item_edit_page.dart';
  final String idCollection;
  final String titleCollection;
  final String subTitleCollection;
  final String qualityCollection;
  final String imageCollection;
  final String dataCollection;
  final String totalTimeCollection;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CollectionItemEditPageModel>(
      create: (BuildContext context) => CollectionItemEditPageModel(),
      child: CollectionItemEditPageCreate(
        idCollection: idCollection,
        titleCollection: titleCollection,
        subTitleCollection: subTitleCollection,
        qualityCollection: qualityCollection,
        imageCollection: imageCollection,
        dataCollection: dataCollection,
        totalTimeCollection: totalTimeCollection,
      ),
    );
  }
}

class CollectionItemEditPageCreate extends StatelessWidget {
  const CollectionItemEditPageCreate({
    Key? key,
    required this.idCollection,
    required this.titleCollection,
    required this.subTitleCollection,
    required this.qualityCollection,
    required this.imageCollection,
    required this.dataCollection,
    required this.totalTimeCollection,
  }) : super(key: key);
  final String idCollection;
  final String titleCollection;
  final String subTitleCollection;
  final String qualityCollection;
  final String imageCollection;
  final String dataCollection;
  final String totalTimeCollection;
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
                  children: [
                    AppbarHeaderCollectionItemEdit(
                      subTitleCollection: subTitleCollection,
                      idCollection: idCollection,
                      imageCollection: imageCollection,
                      titleCollection: titleCollection,
                    ),
                    PhotoContainer(
                      imageCollection: imageCollection,
                    ),
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
                      SubTitleCollectionItemEdit(
                        subTitleCollection: subTitleCollection,
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: ListCollectionsAudioItemEdit(
                          idCollection: idCollection,
                        ),
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
