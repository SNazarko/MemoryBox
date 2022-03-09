import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio/widgets/appbar_header_collection_add_audio.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio/widgets/done_widget/model_done.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio/widgets/list_players_collection_add_audio.dart';
import 'package:provider/provider.dart';

class CollectionsAddAudio extends StatelessWidget {
  const CollectionsAddAudio({Key? key}) : super(key: key);
  static const routeName = '/collection_add_audio';
  static Widget create() {
    return ChangeNotifierProvider<ModelDone>(
      create: (BuildContext context) => ModelDone(),
      child: const CollectionsAddAudio(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ListPlayersCollectionAddAudio(),
                const AppbarHeaderCollectionAddAudio(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
