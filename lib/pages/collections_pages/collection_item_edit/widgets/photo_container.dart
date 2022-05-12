import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/uncategorized/container_shadow.dart';
import 'package:memory_box/widgets/button/icon_camera.dart';

import '../blocs/get_image_cubit/get_image_cubit.dart';

class PhotoContainer extends StatelessWidget {
  const PhotoContainer({Key? key, required this.imageCollection})
      : super(key: key);
  final String imageCollection;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (imageCollection == '') {
      return BlocBuilder<GetImageCollectionItemEditCubit,
          GetImageCollectionItemEditState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              top: 150.0,
              right: 15.0,
            ),
            child: ContainerShadow(
              image: state.image != null
                  ? Image.network(
                      '${state.image}',
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
                    context.read<GetImageCollectionItemEditCubit>().getImage(),
                colorBorder: AppColor.white100,
                position: 0.0,
              ),
              radius: 20.0,
            ),
          );
        },
      );
    } else {
      return BlocBuilder<GetImageCollectionItemEditCubit,
          GetImageCollectionItemEditState>(
        builder: (_, state) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              top: 150.0,
              right: 15.0,
            ),
            child: ContainerShadow(
              image: state.image != null
                  ? Image.network(
                      '${state.image}',
                      fit: BoxFit.fitWidth,
                    )
                  : Image.network(
                      imageCollection,
                      fit: BoxFit.fitWidth,
                    ),
              width: screenWidth * 0.955,
              height: 200.0,
              widget: IconCamera(
                color: AppColor.glass,
                onTap: () =>
                    context.read<GetImageCollectionItemEditCubit>().getImage(),
                colorBorder: AppColor.white100,
                position: 0.0,
              ),
              radius: 20.0,
            ),
          );
        },
      );
    }
  }
}
