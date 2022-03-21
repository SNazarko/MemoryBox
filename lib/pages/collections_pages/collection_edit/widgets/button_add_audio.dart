import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio/collections_add_audio.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../repositories/audio_repositories.dart';
import '../collection_edit_model.dart';

class ButtonAddAudio extends StatelessWidget {
  ButtonAddAudio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          CollectionsRepositories().addCollections(
            Provider.of<CollectionsEditModel>(context, listen: false)
                    .getTitle ??
                '',
            Provider.of<CollectionsEditModel>(context, listen: false)
                    .getTitle ??
                '',
            Provider.of<CollectionsEditModel>(context, listen: false)
                    .getSubTitle ??
                '',
            Provider.of<CollectionsEditModel>(context, listen: false)
                    .getImage ??
                '',
          );

          // CollectionsRepositories().addAudioCollections(
          //   Provider.of<CollectionsEditModel>(context, listen: false)
          //           .getTitle ??
          //       '',
          // );

          Navigator.pushNamed(context, CollectionsAddAudio.routeName);
        },
        child: const Center(
          child: Text(
            'Добавить аудиофайл',
            style: TextStyle(
              color: AppColor.colorText80,
              fontSize: 14.0,
              decoration: TextDecoration.underline,
            ),
          ),
        ));
  }
}
