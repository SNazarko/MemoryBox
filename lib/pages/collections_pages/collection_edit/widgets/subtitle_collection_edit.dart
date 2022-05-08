import 'package:flutter/material.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:provider/src/provider.dart';
import '../../../../repositories/collections_repositories.dart';
import '../collection_edit_model.dart';

class SubTitleCollectionEdit extends StatelessWidget {
  const SubTitleCollectionEdit({
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

  void _updateCollection(BuildContext context) {
    CollectionsRepositories.instance!.updateCollection(
      idCollection,
      Provider.of<CollectionsEditModel>(context, listen: false).getTitle ??
          titleCollection,
      Provider.of<CollectionsEditModel>(context, listen: false).getSubTitle ??
          subTitleCollection,
      Provider.of<CollectionsEditModel>(context, listen: false).getImage ??
          imageCollection,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15.0,
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 28.0,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Введите описание...',
              style: kBodi2TextStyle,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: TextField(
            maxLines: 3,
            onChanged: (subTitle) {
              context.read<CollectionsEditModel>().userSubTitle(subTitle);
            },
            style: const TextStyle(
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 10.0,
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                _updateCollection(context);

                Navigator.pop(context);
              },
              child: const Text(
                'Готово',
                style: kLinkColorText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
