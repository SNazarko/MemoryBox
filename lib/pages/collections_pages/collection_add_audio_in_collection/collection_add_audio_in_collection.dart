import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio_in_collection/widgets/appbar_header_collection_add_audio_in_collection.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio_in_collection/widgets/list_collection_add_audio_in_collection.dart';
import 'package:provider/provider.dart';
import 'collection_add_audio_in_collection_model.dart';

class CollectionAddAudioInCollection extends StatelessWidget {
  const CollectionAddAudioInCollection({Key? key}) : super(key: key);
  static const routeName = '/collection_add_audio_in_collection';
  static Widget create() {
    return ChangeNotifierProvider<CollectionAddAudioInCollectionModel>(
        create: (BuildContext context) => CollectionAddAudioInCollectionModel(),
        child: const CollectionAddAudioInCollection());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const AppbarHeaderCollectionAddAudioInCollection(),
            ListCollectionAddAudioInCollection(),
          ],
        ),
      ),
    );
  }
}
