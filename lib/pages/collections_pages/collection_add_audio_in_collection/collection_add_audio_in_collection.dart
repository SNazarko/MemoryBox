import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio_in_collection/widgets/appbar_header_collection_add_audio_in_collection.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio_in_collection/widgets/list_collection_add_audio_in_collection.dart';

import 'bloc/list_collection_add_audio_in_collection/list_collection_add_audio_in_collection_bloc.dart';

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
    return BlocProvider<ListCollectionAddAudioInCollectionBloc>(
      create: (context) => ListCollectionAddAudioInCollectionBloc()
        ..add(const LoadListCollectionAddAudioInCollectionEvent()),
      child: Scaffold(
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
      ),
    );
  }
}
