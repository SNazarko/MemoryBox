import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio/widgets/appbar_header_collection_add_audio.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio/widgets/list_players_collection_add_audio.dart';
import 'bloc/collection_add_audio/collection_add_audio_bloc.dart';

class CollectionsAddAudioArguments {
  CollectionsAddAudioArguments({
    required this.titleCollections,
  });
  final String titleCollections;
}

class CollectionsAddAudio extends StatelessWidget {
  const CollectionsAddAudio({
    Key? key,
    required this.titleCollections,
  }) : super(key: key);
  static const routeName = '/collection_add_audio';
  final String titleCollections;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CollectionAddAudioBloc>(
          create: (context) => CollectionAddAudioBloc()
            ..add(
              const LoadCollectionAddAudioEvent(),
            ),
        ),
      ],
      child: Scaffold(
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
      ),
    );
  }
}
