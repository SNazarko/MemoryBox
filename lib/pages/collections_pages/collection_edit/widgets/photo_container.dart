import 'package:flutter/cupertino.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/uncategorized/container_shadow.dart';
import 'package:memory_box/widgets/button/icon_camera.dart';
import 'package:provider/src/provider.dart';

import '../collection_edit_model.dart';

class PhotoContainer extends StatefulWidget {
  const PhotoContainer({Key? key}) : super(key: key);

  @override
  State<PhotoContainer> createState() => _PhotoContainerState();
}

class _PhotoContainerState extends State<PhotoContainer> {
  // final ImagePick _imagePick = ImagePick();
  // String? _singleImage;
  //
  // Future<void> _imagePickPhoto(BuildContext context) async {
  //   XFile? _image = await _imagePick.singleImagePick();
  //   if (_image != null && _image.path.isNotEmpty) {
  //     _singleImage = await UserRepositories().uploadImage(_image);
  //     // context.read<CollectionsEditModel>().image(_singleImage ?? '');
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final singleImage = context.watch<CollectionsEditModel>().getSingleImage;
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
          // onTap: () => _imagePickPhoto(context),
          onTap: () => Provider.of<CollectionsEditModel>(context, listen: false)
              .imagePickPhoto(context),
          colorBorder: AppColor.colorText80,
          position: 0.0,
        ),
        radius: 20.0,
      ),
    );
  }
}
