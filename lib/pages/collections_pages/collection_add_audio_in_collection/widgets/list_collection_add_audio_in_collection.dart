import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/list_collection_add_audio_in_collection/list_collection_add_audio_in_collection_bloc.dart';
import 'model_audio_collection_add_audio_in_collection.dart';

class ListCollectionAddAudioInCollection extends StatelessWidget {
  const ListCollectionAddAudioInCollection({
    Key? key,
    required this.collectionAudio,
    required this.idAudio,
  }) : super(key: key);
  final List collectionAudio;
  final String idAudio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90.0),
      child: BlocBuilder<ListCollectionAddAudioInCollectionBloc,
          ListCollectionAddAudioInCollectionState>(
        builder: (context, state) {
          if (state.status ==
              ListCollectionAddAudioInCollectionStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status ==
              ListCollectionAddAudioInCollectionStatus.success) {
            return GridView.builder(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              itemCount: state.list.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                crossAxisCount: 2,
                childAspectRatio: 0.76,
              ),
              itemBuilder: (BuildContext context, int index) {
                final collections = state.list[index];
                return ModelAudioCollectionAddAudioInCollection(
                  id: '${collections.id}',
                  image: '${collections.avatarCollections}',
                  title: '${collections.titleCollections}',
                  subTitle: '${collections.subTitleCollections}',
                  data: '${collections.dateTime}',
                  quality: '${collections.qualityCollections}',
                  doneCollection: collections.doneCollection,
                  totalTime: '${collections.totalTime}',
                  idAudio: idAudio,
                  collectionAudio: collectionAudio,
                );
              },
            );
          }
          if (state.status == ListCollectionAddAudioInCollectionStatus.failed) {
            return const Center(
              child: Text('Ой: сталася помилка!'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
