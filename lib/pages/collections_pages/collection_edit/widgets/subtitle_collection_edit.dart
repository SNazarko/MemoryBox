import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:provider/src/provider.dart';
import '../collection_edit_model.dart';

class SubTitleCollectionEdit extends StatelessWidget {
  const SubTitleCollectionEdit({Key? key}) : super(key: key);

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
          child: Text(
            'Введите описание...',
            style: kBodi2TextStyle,
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
              onPressed: () {},
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
