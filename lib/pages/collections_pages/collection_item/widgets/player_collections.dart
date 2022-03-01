import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:provider/provider.dart';
import '../collections_item_page_model.dart';

class PlayerCollections extends StatelessWidget {
  const PlayerCollections(
      {Key? key, required this.screenHeight, required this.screenWight})
      : super(key: key);
  final double screenHeight;
  final double screenWight;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.9,
      width: screenWight,
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: EdgeInsets.only(bottom: 0.0),
              child: Visibility(
                visible: true,
                child: Container(
                    width: double.infinity,
                    height: context.watch<CollectionsItemPageModel>().getAnim *
                        75.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF8C84E2).withOpacity(context
                              .watch<CollectionsItemPageModel>()
                              .getAnim),
                          const Color(0xFF6C689F).withOpacity(context
                              .watch<CollectionsItemPageModel>()
                              .getAnim),
                        ],
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(40.0),
                      ),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SizedBox(
                              width: context
                                      .watch<CollectionsItemPageModel>()
                                      .getAnim *
                                  50.0,
                              height: context
                                      .watch<CollectionsItemPageModel>()
                                      .getAnim *
                                  50.0,
                              child: Image.asset(
                                AppIcons.play_white,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Малышь Кокки 1',
                                style: TextStyle(
                                    fontFamily: 'TTNorms',
                                    fontSize: context
                                            .watch<CollectionsItemPageModel>()
                                            .getAnim *
                                        14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '----------------------------------',
                                style: TextStyle(
                                    fontFamily: 'TTNorms',
                                    fontSize: context
                                            .watch<CollectionsItemPageModel>()
                                            .getAnim *
                                        14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '00:00',
                                    style: TextStyle(
                                        fontFamily: 'TTNorms',
                                        fontSize: context
                                                .watch<
                                                    CollectionsItemPageModel>()
                                                .getAnim *
                                            10.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    width: context
                                            .watch<CollectionsItemPageModel>()
                                            .getAnim *
                                        140.0,
                                  ),
                                  Text(
                                    '00:00',
                                    style: TextStyle(
                                        fontFamily: 'TTNorms',
                                        fontSize: context
                                                .watch<
                                                    CollectionsItemPageModel>()
                                                .getAnim *
                                            10.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child: GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  AppIcons.next,
                                  width: context
                                          .watch<CollectionsItemPageModel>()
                                          .getAnim *
                                      24.0,
                                  height: context
                                          .watch<CollectionsItemPageModel>()
                                          .getAnim *
                                      24.0,
                                )),
                          )
                        ])),
              ))),
    );
  }
}
