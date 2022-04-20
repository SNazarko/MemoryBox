import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio/collections_add_audio.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:provider/provider.dart';
import '../collection_edit_model.dart';

class ButtonAddAudio extends StatelessWidget {
  const ButtonAddAudio({
    Key? key,
    required this.idCollection,
    required this.titleCollection,
    required this.subTitleCollection,
    required this.imageCollection,
  }) : super(key: key);
  final String idCollection;
  final String titleCollection;
  final String subTitleCollection;
  final String imageCollection;

  void _addAudioInCollection(BuildContext context, String title) {
    CollectionsRepositories().updateCollection(
        idCollection,
        Provider.of<CollectionsEditModel>(context, listen: false).getTitle ??
            titleCollection,
        Provider.of<CollectionsEditModel>(context, listen: false).getSubTitle ??
            subTitleCollection,
        Provider.of<CollectionsEditModel>(context, listen: false).getImage ??
            imageCollection);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CollectionsAddAudio(titleCollections: title);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final title =
        Provider.of<CollectionsEditModel>(context, listen: false).getTitle ??
            titleCollection;
    return TextButton(
        onPressed: () => _addAudioInCollection(context, title),
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
