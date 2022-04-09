import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/audio_model.dart';
import '../../../repositories/audio_repositories.dart';
import '../../../resources/app_colors.dart';
import '../../../widgets/player_mini/player_mini.dart';
import '../delete_page.dart';
import '../delete_page_model.dart';
import 'icon_delene_audio.dart';
import 'icon_done_delete.dart';

class ListPlayersDeletePage extends StatelessWidget {
  ListPlayersDeletePage({Key? key}) : super(key: key);
  final AudioRepositories repAudio = AudioRepositories();

  Widget buildAudioDel(AudioModel audio) => PlayerMini(
        duration: '${audio.duration}',
        url: '${audio.audioUrl}',
        name: '${audio.audioName}',
        done: audio.done!,
        id: '${audio.id}',
        collection: audio.collections!,
        popupMenu: IconDeleteAudio(
          idAudio: '${audio.id}',
          size: audio.size!,
        ),
      );

  Widget buildAudioDone(AudioModel audio) => PlayerMini(
      duration: '${audio.duration}',
      url: '${audio.audioUrl}',
      name: '${audio.audioName}',
      done: audio.done!,
      id: '${audio.id}',
      collection: audio.collections!,
      popupMenu: IconDoneDelete(
        done: audio.done!,
        id: '${audio.id}',
      ));

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DeletePageModel>().getItemDone;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.95,
          child: StreamBuilder<List<AudioModel>>(
            stream: repAudio.readAudioDelete('all'),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Ошибка');
              }
              if (snapshot.hasData) {
                final audio = snapshot.data!;
                if (audio.isEmpty) {
                  return const Center(
                      child: Text(
                    'Вы еще ничего \n     не удалили',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColor.colorText50,
                    ),
                  ));
                } else {
                  return ListView(
                      padding: const EdgeInsets.only(top: 130.0, bottom: 110.0),
                      children: state
                          ? audio.map(buildAudioDone).toList()
                          : audio.map(buildAudioDel).toList());
                }
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
