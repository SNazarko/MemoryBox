import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/view_model.dart';
import '../../../../repositories/collections_repositories.dart';
import '../../../../resources/app_colors.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/uncategorized/appbar_clipper.dart';
import '../../collection_edit/collection_edit.dart';
import '../../collection_edit/collection_edit_model.dart';

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
                  var uuid = const Uuid();
                  var id = uuid.v1();
                  CollectionsRepositories()
                      .addCollections('Без названия', '...', '', id);
                  // Provider.of<CollectionsEditModel>(context, listen: false)
                  //     .setId(id);
                  // Provider.of<CollectionsEditModel>(context, listen: false)
                  //     .userTitle('Без названия');
                  // Provider.of<CollectionsEditModel>(context, listen: false)
                  //     .userSubTitle('...');
                  // Provider.of<CollectionsEditModel>(context, listen: false)
                  //     .image('');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CollectionsEdit(
                      idCollection: id,
                      titleCollection: 'Без названия',
                      subTitleCollection: '...',
                      imageCollection: '',
                    );
                  }));
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
