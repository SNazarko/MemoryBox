import 'package:flutter/material.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:provider/provider.dart';

import '../save_page_model.dart';

class CancelDoneSavePage extends StatelessWidget {
  CancelDoneSavePage({
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
  final AudioRepositories _rep = AudioRepositories();
  final String idAudio;
  final String audioName;
  final String audioUrl;
  final String audioDuration;
  final bool audioDone;
  final String audioTime;
  final List audioSearchName;
  final List audioCollection;

  void _finished(BuildContext context) {
    _rep.renameAudio(
      idAudio,
      Provider.of<SavePageModel>(context, listen: false).getNewAudioName ??
          audioName,
      audioUrl,
      audioDuration,
      audioTime,
      Provider.of<SavePageModel>(context, listen: false).getNewSearchName ??
          audioSearchName,
      audioCollection,
      audioDone,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
              onPressed: () => _finished(context),
              child: const Text(
                'Готово',
                style: kTitle3TextStyle3,
              )),
        ],
      ),
    );
  }
}
