import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio/collections_add_audio.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import '../blocs/collection_edit/collection_edit_bloc.dart';
import '../blocs/get_image_cubit/get_image_cubit.dart';

class ButtonAddAudio extends StatelessWidget {
  const ButtonAddAudio({
    Key? key,
    required this.idCollection,
    required this.titleCollection,
    required this.subTitleCollection,
    required this.imageCollection,
  }) : super(key: key);
  final String idCollection;
  final String titleCollection;
  final String subTitleCollection;
  final String imageCollection;

  void _addAudioInCollection(
    BuildContext context,
    state,
    stateImage,
  ) {
    final title = state.title ?? titleCollection;
    CollectionsRepositories.instance.updateCollection(
      idCollection,
      state.title ?? titleCollection,
      state.subTitle ?? subTitleCollection,
      stateImage.image ?? imageCollection,
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return CollectionsAddAudio(
          titleCollections: title,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionEditBloc, CollectionEditState>(
      builder: (_, state) {
        return BlocBuilder<GetImageCubit, GetImageState>(
          builder: (_, stateImage) {
            return TextButton(
              onPressed: () => _addAudioInCollection(
                context,
                state,
                stateImage,
              ),
              child: const Center(
                child: Text(
                  'Добавить аудиофайл',
                  style: TextStyle(
                    color: AppColor.colorText80,
                    fontSize: 14.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
