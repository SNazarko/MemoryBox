import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import '../../../../widgets/player/player_mini/player_mini.dart';
import 'done_collection_item_edit_audio.dart';

class ListCollectionItemEditAudio extends StatelessWidget {
  const ListCollectionItemEditAudio({Key? key, required this.idCollection})
      : super(key: key);
  final String idCollection;

  Widget buildAudio(AudioModel audio) => PlayerMini(
        duration: '${audio.duration}',
        url: '${audio.audioUrl}',
        name: '${audio.audioName}',
        done: audio.done!,
        id: '${audio.id}',
        collection: audio.collections!,
        popupMenu: DoneCollectionItemEditAudio(
          done: audio.done,
          name: '${audio.audioName}',
          collection: audio.collections,
          id: '${audio.id}',
          idCollection: idCollection,
        ),
      );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder<List<AudioModel>>(
        stream: AudioRepositories.instance.readAudioSort('all'),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Ошибка');
          }
          if (snapshot.hasData) {
            final audio = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.only(bottom: 80.0),
              children: audio.map(buildAudio).toList(),
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
