import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_icons.dart';
import '../../../../widgets/button/icon_camera.dart';
import '../profile_edit_page_model.dart';

class PhotoProfileEdit extends StatelessWidget {
  const PhotoProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final singleImage = context.watch<ProfileEditPageModel>().getSingleImage;
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
            onTap: () =>
                Provider.of<ProfileEditPageModel>(context, listen: false)
                    .onTapPhoto(context),
            color: AppColor.black50,
            position: 0.0,
          ),
        )
      ],
    );
  }
}
