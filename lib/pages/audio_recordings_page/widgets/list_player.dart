import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/popup_menu_audio_recording.dart';

import '../../../widgets/player/player_mini/player_mini.dart';
import '../blocs/bloc_list/audio_recordings_list_bloc.dart';
import '../blocs/bloc_list/audio_recordings_list_state.dart';

class ListPlayer extends StatelessWidget {
  const ListPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight - 140.0,
      child: BlocBuilder<AudioRecordingsListBloc, AudioRecordingsListState>(
          builder: (context, state) {
        if (state.status == AudioRecordingsListStateStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == AudioRecordingsListStateStatus.loaded) {
          return ListView.builder(
            padding: const EdgeInsets.only(top: 135.0, bottom: 110.0),
            itemCount: state.loadedAudio.length,
            itemBuilder: (BuildContext context, int index) {
              final audio = state.loadedAudio[index];
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
        } else {
          return const Center(child: Text('Ouch: There was an error!'));
        }
      }),
    );
  }
}
