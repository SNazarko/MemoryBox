import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:provider/provider.dart';

import '../save_page_model.dart';

class CancelDoneSavePage extends StatelessWidget {
  CancelDoneSavePage({Key? key}) : super(key: key);
  final AudioRepositories _rep = AudioRepositories();

  void _finished(BuildContext context) {
    _rep.renameAudio(
      Provider.of<SavePageModel>(context, listen: false).getIdAudio,
      Provider.of<SavePageModel>(context, listen: false).getNewAudioName ??
          Provider.of<SavePageModel>(context, listen: false).getAudioName,
      Provider.of<SavePageModel>(context, listen: false).getAudioUrl,
      Provider.of<SavePageModel>(context, listen: false).getDuration,
      Provider.of<SavePageModel>(context, listen: false).getDateTime,
      Provider.of<SavePageModel>(context, listen: false).getNewSearchName ??
          Provider.of<SavePageModel>(context, listen: false).getSearchName,
      Provider.of<SavePageModel>(context, listen: false).getCollection,
      Provider.of<SavePageModel>(context, listen: false).getDone,
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
