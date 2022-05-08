import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/resources/app_colors.dart';
import '../../../Blocs/navigation_bloc/navigation__bloc.dart';
import '../../../Blocs/navigation_bloc/navigation__state.dart';
import '../../../widgets/navigation/navigate_to_page.dart';
import '../../../widgets/uncategorized/appbar_clipper.dart';
import '../../../widgets/uncategorized/home_page_containers/blue_container.dart';
import '../../../widgets/uncategorized/home_page_containers/green_container.dart';
import '../../../widgets/uncategorized/home_page_containers/orange_container.dart';
import '../../collections_pages/collection/collection.dart';
import '../blocs/blue _list_collections/blue_list_collections_bloc.dart';
import '../blocs/green_list_collections/green_list_collections_bloc.dart';
import '../blocs/orange_list_collections/orange_list_collections_bloc.dart';

class AppbarHeaderHomePage extends StatelessWidget {
  const AppbarHeaderHomePage({Key? key}) : super(key: key);
  final bool _shouldPop = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return _shouldPop;
      },
      child: Stack(
        children: [
          Container(
            height: screenHeight * 0.374,
          ),
          ClipPath(
            clipper: AppbarClipper(),
            child: Container(
              color: AppColor.colorAppbar,
              width: double.infinity,
              height: 200.0,
            ),
          ),
          _TitleAppbar(
            screenWidth: screenWidth,
          ),
          _GreenListCollections(
            screenWidth: screenWidth,
          ),
          _OrangeListCollections(
            screenWidth: screenWidth,
          ),
          _BlueListCollections(
            screenWidth: screenWidth,
          ),
        ],
      ),
    );
  }
}

class _TitleAppbar extends StatelessWidget {
  const _TitleAppbar({Key? key, required this.screenWidth}) : super(key: key);
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Positioned(
          top: 0.0,
          child: SizedBox(
            width: screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Подборки',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () => NavigateToPage.instance?.navigate(context,
                        index: 1,
                        currentIndex: state.currentIndex,
                        route: Collections.routeName),
                    child: const Text(
                      'Открыть все',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ContainerModel extends StatelessWidget {
  const _ContainerModel({
    Key? key,
    required this.screenWidth,
    required this.image,
    required this.title,
    required this.quality,
    required this.totalTime,
    required this.height,
    required this.boxFit,
  }) : super(key: key);
  final BoxFit boxFit;
  final double height;
  final double screenWidth;
  final String image;
  final String title;
  final String quality;
  final String totalTime;

  Widget imageInContainer(String image, double screenWidth) {
    if (image != '') {
      return SizedBox(
        width: screenWidth / 2.3,
        height: height,
        child: Image.network(
          image,
          fit: boxFit,
        ),
      );
    } else {
      return Container(
        width: screenWidth / 2.3,
        height: height,
        color: AppColor.blue300,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            child: imageInContainer(image, screenWidth),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            child: SizedBox(
              width: screenWidth / 2.3,
              height: height,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 5, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      flex: 10,
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: AppColor.white100,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$quality аудио',
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.white100,
                            ),
                          ),
                          Text(
                            '$totalTime часа',
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.white100,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      width: screenWidth / 2.3,
      height: height,
      decoration: const BoxDecoration(
          color: AppColor.blue200,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          )),
    );
  }
}

class _BlueListCollections extends StatelessWidget {
  const _BlueListCollections({Key? key, required this.screenWidth})
      : super(key: key);
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 135.0,
      right: 0.0,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 16.0,
          top: 24.0,
        ),
        child: BlocBuilder<BlueListItemBloc, BlueListItemState>(
          builder: (context, state) {
            if (state.status == BlueListItemStatus.initial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.status == BlueListItemStatus.failed) {
              return BlueContainer(
                screenWidth: screenWidth,
              );
            }
            if (state.status == BlueListItemStatus.emptyList) {
              return BlueContainer(
                screenWidth: screenWidth,
              );
            }
            if (state.status == BlueListItemStatus.success) {
              if (state.list.isNotEmpty) {
                final collections = state.list.last;
                return _ContainerModel(
                  image: '${collections.avatarCollections}',
                  title: '${collections.titleCollections}',
                  totalTime: '${collections.totalTime}',
                  quality: '${collections.qualityCollections}',
                  screenWidth: screenWidth,
                  height: 95.0,
                  boxFit: BoxFit.fitWidth,
                );
              } else {
                return BlueContainer(
                  screenWidth: screenWidth,
                );
              }
            } else {
              return SizedBox(
                width: screenWidth / 2.3,
                height: 95.0,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _OrangeListCollections extends StatelessWidget {
  const _OrangeListCollections({Key? key, required this.screenWidth})
      : super(key: key);
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30.0,
      right: 0.0,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          right: 16.0,
        ),
        child: BlocBuilder<OrangeListItemBloc, OrangeListItemState>(
          builder: (context, state) {
            if (state.status == OrangeListItemStatus.initial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.status == OrangeListItemStatus.failed) {
              return OrangeContainer(
                screenWidth: screenWidth,
              );
            }
            if (state.status == OrangeListItemStatus.emptyList) {
              return OrangeContainer(
                screenWidth: screenWidth,
              );
            }
            if (state.status == OrangeListItemStatus.success) {
              if (state.list.length - 2 >= 0) {
                final collections = state.list[state.list.length - 2];
                return _ContainerModel(
                  image: '${collections.avatarCollections}',
                  title: '${collections.titleCollections}',
                  totalTime: '${collections.totalTime}',
                  quality: '${collections.qualityCollections}',
                  screenWidth: screenWidth,
                  boxFit: BoxFit.fitWidth,
                  height: 95.0,
                );
              } else {
                return OrangeContainer(
                  screenWidth: screenWidth,
                );
              }
            } else {
              return SizedBox(
                width: screenWidth / 2.3,
                height: 95.0,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _GreenListCollections extends StatelessWidget {
  const _GreenListCollections({Key? key, required this.screenWidth})
      : super(key: key);
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30.0,
      left: 16.0,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          right: 16.0,
        ),
        child: BlocBuilder<GreenListItemBloc, GreenListItemState>(
          builder: (_, state) {
            if (state.status == GreenListItemStatus.initial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.status == GreenListItemStatus.failed) {
              return GreenContainer(
                screenWidth: screenWidth,
              );
            }
            if (state.status == GreenListItemStatus.emptyList) {
              return GreenContainer(
                screenWidth: screenWidth,
              );
            }
            if (state.status == GreenListItemStatus.success) {
              if (state.list.length - 3 >= 0) {
                final collections = state.list[state.list.length - 3];
                return _ContainerModel(
                  image: '${collections.avatarCollections}',
                  title: '${collections.titleCollections}',
                  totalTime: '${collections.totalTime}',
                  quality: '${collections.qualityCollections}',
                  screenWidth: screenWidth,
                  boxFit: BoxFit.fitHeight,
                  height: 210.0,
                );
              } else {
                return GreenContainer(
                  screenWidth: screenWidth,
                );
              }
            } else {
              return SizedBox(
                width: screenWidth / 2.3,
                height: 210.0,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
