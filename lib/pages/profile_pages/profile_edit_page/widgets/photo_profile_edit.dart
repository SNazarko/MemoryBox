import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../repositories/user_repositories.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_icons.dart';
import '../../../../widgets/icon_camera.dart';
import '../../profile_model.dart';

class PhotoProfileEdit extends StatefulWidget {
  const PhotoProfileEdit({Key? key}) : super(key: key);

  @override
  State<PhotoProfileEdit> createState() => _PhotoProfileEditState();
}

class _PhotoProfileEditState extends State<PhotoProfileEdit> {
  String? singleImage;

  Future<void> onTapPhoto(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    XFile? _image = await UserRepositories().singleImagePick();
    if (_image != null && _image.path.isNotEmpty) {
      singleImage = await UserRepositories().uploadImage(_image);
      context.read<DataModel>().userImage(singleImage!);
      await prefs.setString(
          'image', await UserRepositories().uploadImage(_image));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 110.0),
          child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: singleImage != null && singleImage!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        child: Image.network(
                          singleImage!,
                          fit: BoxFit.cover,
                        ))
                    : ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        child: Image.asset(
                          AppIcons.avatarka,
                          fit: BoxFit.cover,
                        ),
                      ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 110.0),
          child: IconCamera(
            colorBorder: Colors.white,
            onTap: () => onTapPhoto(context),
            // imagePicker,
            color: AppColor.black50,
            position: 0.0,
          ),
        )
      ],
    );
  }
}
