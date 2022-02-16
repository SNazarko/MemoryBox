import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/podborki_item_page_model.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/widgets/player_mini.dart';
import 'package:provider/provider.dart';

class ListPodborokAudio extends StatelessWidget {
  ListPodborokAudio({Key? key, required this.screenHeight}) : super(key: key);
  AudioRepositories repositories = AudioRepositories();
  final double screenHeight;

  Widget buildAudio(AudioModel audio) => PlayerMini(
        duration: '${audio.duration}',
        url: '${audio.audioUrl}',
        name: '${audio.audioName}',
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.5,
      child: StreamBuilder<List<AudioModel>>(
        stream: repositories.readAudioPodbirka(
            '${context.watch<PodborkiItemPageModel>().getTitle}'),
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
