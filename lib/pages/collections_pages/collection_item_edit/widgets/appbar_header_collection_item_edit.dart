import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection/collection.dart';
import 'package:memory_box/pages/collections_pages/collection_item/collections_item_page_model.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/icon_back.dart';
import 'package:provider/provider.dart';

import '../collection_item_edit_page_model.dart';

class AppbarHeaderCollectionItemEdit extends StatefulWidget {
  const AppbarHeaderCollectionItemEdit({Key? key}) : super(key: key);

  @override
  State<AppbarHeaderCollectionItemEdit> createState() =>
      AppbarHeaderCollectionItemEditState();
}

class AppbarHeaderCollectionItemEditState
    extends State<AppbarHeaderCollectionItemEdit> {
  final TextEditingController _controller = TextEditingController();
  final CollectionsRepositories _repositories = CollectionsRepositories();

  @override
  void didChangeDependencies() {
    _controller.text =
        '${Provider.of<CollectionsItemPageModel>(context, listen: false).getTitle}';
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void editCollections(BuildContext context) {
    _repositories.updateCollection(
      Provider.of<CollectionsItemPageModel>(context, listen: false)
          .getIdCollection,
      Provider.of<CollectionItemEditPageModel>(context, listen: false)
              .getTitleCollectionsEdit ??
          Provider.of<CollectionsItemPageModel>(context, listen: false)
              .getTitle,
      Provider.of<CollectionItemEditPageModel>(context, listen: false)
              .getSubTitleCollectionsEdit ??
          Provider.of<CollectionsItemPageModel>(context, listen: false)
              .getSubTitle,
      Provider.of<CollectionItemEditPageModel>(context, listen: false)
              .getAvatarCollectionsEdit ??
          Provider.of<CollectionsItemPageModel>(context, listen: false)
              .getPhoto,
    );
    Navigator.pushNamed(context, Collections.routeName);
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 27.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBack(
                onPressed: () => editCollections(context),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Отменить',
                  style: kTitle2TextStyle2,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 90.0, left: 15.0, right: 15.0),
          child: TextField(
            controller: _controller,
            onChanged: (titleCollectionsEdit) {
              context
                  .read<CollectionItemEditPageModel>()
                  .setTitleCollectionsEdit(titleCollectionsEdit);
            },
            style: const TextStyle(
              fontSize: 24.0,
              color: AppColor.white100,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
