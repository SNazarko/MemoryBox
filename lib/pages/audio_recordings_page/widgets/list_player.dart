import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/popup_menu_audio_recording.dart';

import '../../../blocs/list_item_bloc/list_item_bloc.dart';
import '../../../resources/app_colors.dart';
import '../../../widgets/player/player_mini/player_mini.dart';

class ListPlayer extends StatelessWidget {
  const ListPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight - 140.0,
      child:
          BlocBuilder<ListItemBloc, ListItemState>(builder: (context, state) {
        if (state.status == ListItemStatus.emptyList) {
          return const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 50.0,
              horizontal: 40.0,
            ),
            child: Center(
              child: Text(
                'Как только ты запишешь аудио, она появится здесь.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: AppColor.colorText50,
                ),
              ),
            ),
          );
        }
        if (state.status == ListItemStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == ListItemStatus.success) {
          return ListView.builder(
            padding: const EdgeInsets.only(top: 135.0, bottom: 110.0),
            itemCount: state.list.length,
            itemBuilder: (BuildContext context, int index) {
              final audio = state.list[index];
              return PlayerMini(
                playPause: audio.playPause,
                duration: '${audio.duration}',
                url: '${audio.audioUrl}',
                name: '${audio.audioName}',
                done: audio.done!,
                id: '${audio.id}',
                collection: audio.collections ?? [],
                popupMenu: PopupMenuAudioRecording(
                  url: '${audio.audioUrl}',
                  duration: '${audio.duration}',
                  name: '${audio.audioName}',
                  dateTime: audio.dateTime!,
                  done: audio.done!,
                  searchName: audio.searchName!,
                  idAudio: '${audio.id}',
                  collection: audio.collections!,
                ),
              );
            },
          );
        }
        if (state.status == ListItemStatus.failed) {
          return const Center(
            child: Text('Ой: сталася помилка!'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
