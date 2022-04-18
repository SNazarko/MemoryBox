import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_item/collections_item_page_model.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/uncategorized/container_shadow.dart';
import 'package:memory_box/widgets/button/icon_camera.dart';
import 'package:provider/provider.dart';

import '../collection_item_edit_page_model.dart';

class PhotoContainer extends StatelessWidget {
  const PhotoContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final String? singleImage =
        Provider.of<CollectionItemEditPageModel>(context, listen: false)
            .getSingleImage;
    final String image =
        Provider.of<CollectionsItemPageModel>(context, listen: false).getPhoto;
    if (image == '') {
      return Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          top: 150.0,
          right: 15.0,
        ),
        child: ContainerShadow(
          image: singleImage != null
              ? Image.network(
                  singleImage,
                  fit: BoxFit.fitWidth,
                )
              : Container(
                  color: Colors.grey,
                ),
          width: screenWidth * 0.955,
          height: 200.0,
          widget: IconCamera(
            color: AppColor.glass,
            onTap: () =>
                Provider.of<CollectionItemEditPageModel>(context, listen: false)
                    .imagePickPhoto(context),
            colorBorder: AppColor.white100,
            position: 0.0,
          ),
          radius: 20.0,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          top: 150.0,
          right: 15.0,
        ),
        child: ContainerShadow(
          image: singleImage != null
              ? Image.network(
                  singleImage,
                  fit: BoxFit.fitWidth,
                )
              : Image.network(
                  '${Provider.of<CollectionsItemPageModel>(context, listen: false).getPhoto}',
                  fit: BoxFit.fitWidth,
                ),
          width: screenWidth * 0.955,
          height: 200.0,
          widget: IconCamera(
            color: AppColor.glass,
            onTap: () =>
                Provider.of<CollectionItemEditPageModel>(context, listen: false)
                    .imagePickPhoto(context),
            colorBorder: AppColor.white100,
            position: 0.0,
          ),
          radius: 20.0,
        ),
      );
    }
  }
}
