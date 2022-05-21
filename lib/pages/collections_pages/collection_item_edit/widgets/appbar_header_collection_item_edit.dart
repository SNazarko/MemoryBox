import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/collections_pages/collection/collection.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:memory_box/widgets/button/icon_back.dart';

import '../../../../widgets/uncategorized/appbar_clipper.dart';
import '../blocs/collection_item_edit/collection_item_edit_bloc.dart';
import '../blocs/get_image_cubit/get_image_cubit.dart';

class AppbarHeaderCollectionItemEdit extends StatefulWidget {
  const AppbarHeaderCollectionItemEdit({
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

  @override
  State<AppbarHeaderCollectionItemEdit> createState() =>
      AppbarHeaderCollectionItemEditState();
}

class AppbarHeaderCollectionItemEditState
    extends State<AppbarHeaderCollectionItemEdit> {
  final TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    _controller.text = widget.titleCollection;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _editCollections(
    BuildContext context,
    state,
    stateImage,
  ) {
    CollectionsRepositories.instance.updateCollection(
      widget.idCollection,
      state.title ?? widget.titleCollection,
      state.subTitle ?? widget.subTitleCollection,
      stateImage.image ?? widget.imageCollection,
    );
    Navigator.pushNamed(
      context,
      Collections.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionItemEditBloc, CollectionItemEditState>(
      builder: (_, state) {
        return BlocBuilder<GetImageCollectionItemEditCubit,
            GetImageCollectionItemEditState>(
          builder: (_, stateImage) {
            return Stack(
              children: [
                Container(),
                ClipPath(
                  clipper: AppbarClipper(),
                  child: Container(
                    color: AppColor.colorAppbar2,
                    width: double.infinity,
                    height: 280.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 27.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconBack(
                        onPressed: () => _editCollections(
                          context,
                          state,
                          stateImage,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Отменить',
                          style: kTitle2TextStyle2,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 90.0,
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: TextField(
                    autofocus: true,
                    controller: _controller,
                    onChanged: (titleCollectionsEdit) {
                      context.read<CollectionItemEditBloc>().add(
                            CollectionItemEditEvent(
                              title: titleCollectionsEdit,
                            ),
                          );
                    },
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: AppColor.white100,
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
