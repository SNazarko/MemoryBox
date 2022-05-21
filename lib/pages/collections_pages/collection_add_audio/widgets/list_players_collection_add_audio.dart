import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/widgets/player/player_mini_podborki.dart';
import '../bloc/collection_add_audio/collection_add_audio_bloc.dart';

class ListPlayersCollectionAddAudio extends StatelessWidget {
  const ListPlayersCollectionAddAudio(
      {Key? key, required this.titleCollections})
      : super(key: key);
  final String titleCollections;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.95,
          child: BlocBuilder<CollectionAddAudioBloc, CollectionAddAudioState>(
            builder: (context, state) {
              if (state.status == CollectionAddAudioStatus.initial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == CollectionAddAudioStatus.success) {
                return ListView.builder(
                  padding: const EdgeInsets.only(
                    top: 230.0,
                    bottom: 110.0,
                  ),
                  itemCount: state.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final audio = state.list[index];
                    return PlayerMiniPodborki(
                      duration: '${audio.duration}',
                      url: '${audio.audioUrl}',
                      name: '${audio.audioName}',
                      done: audio.done = false,
                      id: '${audio.id}',
                      collection: audio.collections ?? [],
                      titleCollections: titleCollections,
                    );
                  },
                );
              }
              if (state.status == CollectionAddAudioStatus.failed) {
                return const Center(
                  child: Text(
                    'Ой: сталася помилка!',
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
