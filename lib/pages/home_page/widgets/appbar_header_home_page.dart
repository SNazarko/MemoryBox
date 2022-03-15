import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/collections_model.dart';
import 'package:memory_box/models/view_model.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:provider/src/provider.dart';

import '../../../widgets/home_page_containers/blue_container.dart';
import '../../../widgets/home_page_containers/green_container.dart';
import '../../../widgets/home_page_containers/orange_container.dart';

class AppbarHeaderHomePage extends StatelessWidget {
  const AppbarHeaderHomePage({Key? key}) : super(key: key);
  final bool shouldPop = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
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
                onTap: () {
                  Provider.of<Navigation>(context, listen: false)
                      .setCurrentIndex = 1;
                },
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
  }
}

class _MaxContainerModel extends StatelessWidget {
  const _MaxContainerModel(
      {Key? key,
      required this.screenWidth,
      required this.image,
      required this.title,
      required this.quality,
      required this.time})
      : super(key: key);
  final double screenWidth;
  final String image;
  final String title;
  final String quality;
  final String time;

  Widget imageInContainer(String image, double screenWidth) {
    if (image != '') {
      return SizedBox(
        width: screenWidth / 2.3,
        height: 210.0,
        child: Image.network(
          image,
          fit: BoxFit.fitHeight,
        ),
      );
    } else {
      return Container(
        width: screenWidth / 2.3,
        height: 210.0,
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
              height: 210.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 5, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
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
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            '7 аудио',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.white100,
                            ),
                          ),
                          Text(
                            '3:33 часа',
                            style: TextStyle(
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
      height: 210.0,
      decoration: const BoxDecoration(
          color: AppColor.blue200,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          )),
    );
  }
}

class _MiniContainerModel extends StatelessWidget {
  const _MiniContainerModel(
      {Key? key,
      required this.screenWidth,
      required this.image,
      required this.title,
      required this.quality,
      required this.time})
      : super(key: key);
  final double screenWidth;
  final String image;
  final String title;
  final String quality;
  final String time;

  Widget imageInContainer(String image, double screenWidth) {
    if (image != '') {
      return SizedBox(
        width: screenWidth / 2.3,
        height: 95.0,
        child: Image.network(
          image,
          fit: BoxFit.fitWidth,
        ),
      );
    } else {
      return Container(
        width: screenWidth / 2.3,
        height: 95.0,
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
              height: 95.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 5, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
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
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            '7 аудио',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.white100,
                            ),
                          ),
                          Text(
                            '3:33 часа',
                            style: TextStyle(
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
      height: 95.0,
      decoration: const BoxDecoration(
          color: AppColor.blue200,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          )),
    );
  }
}

class _BlueListCollections extends StatelessWidget {
  _BlueListCollections({Key? key, required this.screenWidth}) : super(key: key);
  final CollectionsRepositories repositories = CollectionsRepositories();
  final double screenWidth;

  Widget buildCollections(CollectionsModel collections) => _MiniContainerModel(
        image: '${collections.avatarCollections}',
        title: '${collections.titleCollections}',
        time: '${collections.data}',
        quality: '${collections.qualityCollections}',
        screenWidth: screenWidth,
      );

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
        child: StreamBuilder<List<CollectionsModel>>(
          stream: repositories.readCollections(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return BlueContainer(
                screenWidth: screenWidth,
              );
            }
            if (snapshot.hasData) {
              final collections = snapshot.data!;
              if (collections.map(buildCollections).toList().isNotEmpty) {
                return Container(
                  child: collections.map(buildCollections).toList().last,
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
  _OrangeListCollections({Key? key, required this.screenWidth})
      : super(key: key);
  final CollectionsRepositories repositories = CollectionsRepositories();
  final double screenWidth;

  Widget buildCollections(CollectionsModel collections) => _MiniContainerModel(
        image: '${collections.avatarCollections}',
        title: '${collections.titleCollections}',
        time: '${collections.data}',
        quality: '${collections.qualityCollections}',
        screenWidth: screenWidth,
      );

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
        child: StreamBuilder<List<CollectionsModel>>(
          stream: repositories.readCollections(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return OrangeContainer(
                screenWidth: screenWidth,
              );
            }
            if (snapshot.hasData) {
              final collections = snapshot.data!;
              if (collections.map(buildCollections).toList().length - 2 >= 0) {
                return Container(
                  child: collections.map(buildCollections).toList()[
                      collections.map(buildCollections).toList().length - 2],
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
  _GreenListCollections({Key? key, required this.screenWidth})
      : super(key: key);
  final CollectionsRepositories repositories = CollectionsRepositories();
  final double screenWidth;

  Widget buildCollections(CollectionsModel collections) => _MaxContainerModel(
        image: '${collections.avatarCollections}',
        title: '${collections.titleCollections}',
        time: '${collections.data}',
        quality: '${collections.qualityCollections}',
        screenWidth: screenWidth,
      );

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
        child: StreamBuilder<List<CollectionsModel>>(
          stream: repositories.readCollections(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return GreenContainer(
                screenWidth: screenWidth,
              );
            }
            if (snapshot.hasData) {
              final collections = snapshot.data!;
              if (collections.map(buildCollections).toList().length - 3 >= 0) {
                return Container(
                  child: collections.map(buildCollections).toList()[
                      collections.map(buildCollections).toList().length - 3],
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
