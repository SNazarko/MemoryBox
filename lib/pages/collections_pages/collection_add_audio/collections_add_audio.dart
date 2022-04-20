import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio/widgets/appbar_header_collection_add_audio.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio/widgets/done_widget/model_done.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio/widgets/list_players_collection_add_audio.dart';
import 'package:provider/provider.dart';

import 'collections_add_audio_model.dart';

class CollectionsAddAudioArguments {
  CollectionsAddAudioArguments({required this.titleCollections});
  final String titleCollections;
}

class CollectionsAddAudio extends StatelessWidget {
  const CollectionsAddAudio({Key? key, required this.titleCollections})
      : super(key: key);
  static const routeName = '/collection_add_audio';
  final String titleCollections;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelDone>(
          create: (BuildContext context) => ModelDone(),
        ),
        ChangeNotifierProvider<CollectionsAddAudioModel>(
            create: (BuildContext context) => CollectionsAddAudioModel()),
      ],
      child: CollectionsAddAudioCreate(
        titleCollections: titleCollections,
      ),
    );
  }
}

class CollectionsAddAudioCreate extends StatelessWidget {
  const CollectionsAddAudioCreate({Key? key, required this.titleCollections})
      : super(key: key);
  final String titleCollections;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ListPlayersCollectionAddAudio(
                  titleCollections: titleCollections,
                ),
                const AppbarHeaderCollectionAddAudio(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
