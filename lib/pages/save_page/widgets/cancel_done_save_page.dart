import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/utils/constants.dart';
import '../bloc/save_page/save_page_bloc.dart';

class CancelDoneSavePage extends StatelessWidget {
  const CancelDoneSavePage({
    Key? key,
    required this.idAudio,
    required this.audioName,
    required this.audioUrl,
    required this.audioDuration,
    required this.audioDone,
    required this.audioTime,
    required this.audioSearchName,
    required this.audioCollection,
  }) : super(key: key);
  final String idAudio;
  final String audioName;
  final String audioUrl;
  final String audioDuration;
  final bool audioDone;
  final String audioTime;
  final List audioSearchName;
  final List audioCollection;

  void _finished(BuildContext context, state) {
    AudioRepositories.instance.renameAudio(
      idAudio,
      state.newAudioName ?? audioName,
      audioUrl,
      audioDuration,
      audioTime,
      state.newSearchName ?? audioSearchName,
      audioCollection,
      audioDone,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavePageBloc, SavePageState>(
      builder: (_, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Отменить',
                    style: kTitle3TextStyle3,
                  )),
              TextButton(
                  onPressed: () => _finished(
                        context,
                        state,
                      ),
                  child: const Text(
                    'Готово',
                    style: kTitle3TextStyle3,
                  )),
            ],
          ),
        );
      },
    );
  }
}
