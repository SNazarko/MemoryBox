import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_icons.dart';
import '../../../../widgets/button/icon_camera.dart';
import '../blocs/get_image_profile_cubit/get_image_profile_cubit.dart';

class PhotoProfileEdit extends StatelessWidget {
  const PhotoProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetImageProfileCubit, GetImageProfileState>(
      builder: (_, state) {
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
                    child: state.image != null && state.image!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            child: Image.network(
                              state.image!,
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
                onTap: () => context.read<GetImageProfileCubit>().getImage(),
                color: AppColor.black50,
                position: 0.0,
              ),
            )
          ],
        );
      },
    );
  }
}
