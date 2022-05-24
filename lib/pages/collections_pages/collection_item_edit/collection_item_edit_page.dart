import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/widgets/appbar_header_collection_item_edit.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/widgets/list_collections_audio_item_edit.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/widgets/photo_container.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/widgets/sub_title_collection_item_edit.dart';
import '../../../blocs/list_item_bloc/list_item_bloc.dart';
import 'blocs/collection_item_edit/collection_item_edit_bloc.dart';
import 'blocs/get_image_cubit/get_image_cubit.dart';

class CollectionItemEditPageArguments {
  CollectionItemEditPageArguments(
    this.idCollection,
    this.titleCollection,
    this.subTitleCollection,
    this.qualityCollection,
    this.imageCollection,
    this.dataCollection,
    this.totalTimeCollection,
  );

  final String idCollection;
  final String titleCollection;
  final String subTitleCollection;
  final String qualityCollection;
  final String imageCollection;
  final String dataCollection;
  final String totalTimeCollection;
}

class CollectionItemEditPage extends StatelessWidget {
  const CollectionItemEditPage(
      {Key? key,
      required this.idCollection,
      required this.titleCollection,
      required this.subTitleCollection,
      required this.qualityCollection,
      required this.imageCollection,
      required this.dataCollection,
      required this.totalTimeCollection})
      : super(key: key);
  static const routeName = '/collection_item_edit_page.dart';
  final String idCollection;
  final String titleCollection;
  final String subTitleCollection;
  final String qualityCollection;
  final String imageCollection;
  final String dataCollection;
  final String totalTimeCollection;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListItemBloc>(
          create: (context) => ListItemBloc()
            ..add(
              LoadListItemEvent(
                sort: idCollection,
                collection: 'Collections',
                nameSort: 'collections',
              ),
            ),
        ),
        BlocProvider<CollectionItemEditBloc>(
          create: (context) => CollectionItemEditBloc(),
        ),
        BlocProvider<GetImageCollectionItemEditCubit>(
          create: (context) => GetImageCollectionItemEditCubit(),
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight - kBottomNavigationBarHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      AppbarHeaderCollectionItemEdit(
                        subTitleCollection: subTitleCollection,
                        idCollection: idCollection,
                        imageCollection: imageCollection,
                        titleCollection: titleCollection,
                      ),
                      PhotoContainer(
                        imageCollection: imageCollection,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15.0,
                        ),
                        SubTitleCollectionItemEdit(
                          subTitleCollection: subTitleCollection,
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: ListCollectionsAudioItemEdit(
                            idCollection: idCollection,
                          ),
                        ),
                      ],
                    ),
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
