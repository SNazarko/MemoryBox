import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/collections_pages/collection_edit/widgets/appbar_header_edit.dart';
import 'package:memory_box/pages/collections_pages/collection_edit/widgets/button_add_audio.dart';
import 'package:memory_box/pages/collections_pages/collection_edit/widgets/photo_container.dart';
import 'package:memory_box/pages/collections_pages/collection_edit/widgets/subtitle_collection_edit.dart';

import 'blocs/collection_edit/collection_edit_bloc.dart';
import 'blocs/get_image_cubit/get_image_cubit.dart';

class CollectionsEditArguments {
  CollectionsEditArguments({
    this.idCollection,
    this.titleCollection,
    this.subTitleCollection,
    this.imageCollection,
  });

  final String? idCollection;
  final String? titleCollection;
  final String? subTitleCollection;
  final String? imageCollection;
}

class CollectionsEdit extends StatelessWidget {
  const CollectionsEdit({
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
  static const routeName = 'collection_edit_dmjmkjj';

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider<CollectionEditBloc>(
          create: (context) => CollectionEditBloc(),
        ),
        BlocProvider<GetImageCubit>(
          create: (context) => GetImageCubit(),
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      AppbarHeaderEdit(
                        subTitleCollection: subTitleCollection,
                        imageCollection: imageCollection,
                        titleCollection: titleCollection,
                        idCollection: idCollection,
                      ),
                      const PhotoContainer(),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubTitleCollectionEdit(
                        subTitleCollection: subTitleCollection,
                        imageCollection: imageCollection,
                        titleCollection: titleCollection,
                        idCollection: idCollection,
                      ),
                      ButtonAddAudio(
                        subTitleCollection: subTitleCollection,
                        idCollection: idCollection,
                        imageCollection: imageCollection,
                        titleCollection: titleCollection,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
