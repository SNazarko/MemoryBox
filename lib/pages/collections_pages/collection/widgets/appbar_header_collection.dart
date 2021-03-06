import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection/widgets/popup_menu_collection_page.dart';
import 'package:memory_box/pages/collections_pages/collection_edit/collection_edit.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../repositories/collections_repositories.dart';
import '../../../../widgets/uncategorized/appbar_clipper.dart';
import '../../collection_edit/collection_edit_model.dart';

class AppbarHeaderCollection extends StatelessWidget {
  const AppbarHeaderCollection({Key? key}) : super(key: key);

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
              PopupMenuCollectionPage(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Все в одном месте',
                style: kTitle2TextStyle2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
