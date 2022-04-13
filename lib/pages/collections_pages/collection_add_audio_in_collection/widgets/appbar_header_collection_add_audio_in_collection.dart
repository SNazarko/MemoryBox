import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/view_model.dart';
import '../../../../repositories/collections_repositories.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/constants.dart';
import '../../../../widgets/appbar_clipper.dart';
import '../../collection_edit/collection_edit.dart';

class AppbarHeaderCollectionAddAudioInCollection extends StatelessWidget {
  const AppbarHeaderCollectionAddAudioInCollection({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(),
        ClipPath(
          clipper: AppbarClipper(),
          child: Container(
            color: AppColor.colorAppbar2,
            width: double.infinity,
            height: 280.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  CollectionsRepositories()
                      .addCollections('Без названия', '...', '', context);
                  Navigator.pushNamed(context, CollectionsEdit.routeName);
                },
                icon: const Icon(
                  Icons.add,
                  size: 35.0,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Подборки',
                style: kTitleTextStyle2,
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<Navigation>(context, listen: false)
                      .setCurrentIndex = 1;
                },
                child: const Text(
                  'Добавить',
                  style: kTitle2TextStyle2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
