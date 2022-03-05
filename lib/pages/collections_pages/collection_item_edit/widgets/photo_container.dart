import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_box/pages/collections_pages/collection_item/collections_item_page_model.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/container_shadow.dart';
import 'package:memory_box/widgets/icon_camera.dart';
import 'package:memory_box/widgets/image_pick.dart';
import 'package:provider/provider.dart';

import '../collection_item_edit_page_model.dart';

class PhotoContainer extends StatefulWidget {
  const PhotoContainer({Key? key}) : super(key: key);

  @override
  State<PhotoContainer> createState() => PhotoContainerState();
}

class PhotoContainerState extends State<PhotoContainer> {
  ImagePick imagePick = ImagePick();
  String? singleImage;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
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
                  '$singleImage',
                  fit: BoxFit.fitWidth,
                )
              : Container(
                  color: Colors.grey,
                ),
          width: screenWidth * 0.955,
          height: 200.0,
          widget: IconCamera(
            color: AppColor.glass,
            onTap: () async {
              XFile? _image = await imagePick.singleImagePick();
              if (_image != null && _image.path.isNotEmpty) {
                singleImage = await UserRepositories().uploadImage(_image);
                context
                    .read<CollectionItemEditPageModel>()
                    .setAvatarCollectionsEdit(singleImage!);
                setState(() {});
              }
            },
            colorBorder: AppColor.colorText80,
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
                  '$singleImage',
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
            onTap: () async {
              XFile? _image = await imagePick.singleImagePick();
              if (_image != null && _image.path.isNotEmpty) {
                singleImage = await UserRepositories().uploadImage(_image);
                context
                    .read<CollectionItemEditPageModel>()
                    .setAvatarCollectionsEdit(singleImage!);
                setState(() {});
              }
            },
            colorBorder: AppColor.colorText80,
            position: 0.0,
          ),
          radius: 20.0,
        ),
      );
    }
  }
}
