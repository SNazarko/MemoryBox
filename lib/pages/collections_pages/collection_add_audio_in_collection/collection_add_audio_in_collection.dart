import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio_in_collection/widgets/appbar_header_collection_add_audio_in_collection.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio_in_collection/widgets/list_collection_add_audio_in_collection.dart';

class CollectionAddAudioInCollectionArgument {
  CollectionAddAudioInCollectionArgument({
    required this.idAudio,
    required this.collectionAudio,
  });
  final List collectionAudio;
  final String idAudio;
}

class CollectionAddAudioInCollection extends StatelessWidget {
  const CollectionAddAudioInCollection(
      {Key? key, required this.collectionAudio, required this.idAudio})
      : super(key: key);
  static const routeName = '/collection_add_audio_in_collection';
  final List collectionAudio;
  final String idAudio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const AppbarHeaderCollectionAddAudioInCollection(),
            ListCollectionAddAudioInCollection(
              collectionAudio: collectionAudio,
              idAudio: idAudio,
            ),
          ],
        ),
      ),
    );
  }
}
