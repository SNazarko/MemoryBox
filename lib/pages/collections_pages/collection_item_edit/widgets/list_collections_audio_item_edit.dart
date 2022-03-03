import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/pages/collections_pages/collection_item/collections_item_page_model.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/player_mini/player_mini.dart';
import 'package:provider/src/provider.dart';

class ListCollectionsAudioItemEdit extends StatelessWidget {
  ListCollectionsAudioItemEdit({Key? key}) : super(key: key);
  final AudioRepositories repositories = AudioRepositories();

  Widget buildAudio(AudioModel audio) => PlayerMini(
      duration: '${audio.duration}',
      url: '${audio.audioUrl}',
      name: '${audio.audioName}',
      popupMenu: const Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: Icon(
          Icons.more_horiz,
          color: AppColor.colorText,
          size: 40.0,
        ),
      ));
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: StreamBuilder<List<AudioModel>>(
            stream: repositories.readAudioPodbirka(
                '${context.watch<CollectionsItemPageModel>().getTitle}'),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Ошибка');
              }
              if (snapshot.hasData) {
                final audio = snapshot.data!;
                return ListView(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  children: audio.map(buildAudio).toList(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}
