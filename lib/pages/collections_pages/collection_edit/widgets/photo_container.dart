import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/container_shadow.dart';
import 'package:memory_box/widgets/icon_camera.dart';
import 'package:memory_box/widgets/image_pick.dart';
import 'package:provider/src/provider.dart';

import '../collection_edit_model.dart';

class PhotoContainer extends StatefulWidget {
  const PhotoContainer({Key? key}) : super(key: key);

  @override
  State<PhotoContainer> createState() => _PhotoContainerState();
}

class _PhotoContainerState extends State<PhotoContainer> {
  ImagePick imagePick = ImagePick();
  String? singleImage;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
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
            : const Text(''),
        width: screenWidth * 0.955,
        height: 200.0,
        widget: IconCamera(
          color: AppColor.glass,
          onTap: () async {
            XFile? _image = await imagePick.singleImagePick();
            if (_image != null && _image.path.isNotEmpty) {
              singleImage = await UserRepositories().uploadImage(_image);
              context.read<CollectionsEditModel>().image(singleImage!);
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
