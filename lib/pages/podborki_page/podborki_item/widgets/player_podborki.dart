import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/podborki_item_page_model.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:provider/provider.dart';

class PlayerPodborki extends StatelessWidget {
  PlayerPodborki({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: true,
      // context.watch<PodborkiItemPageModel>().getPlayPause ?? false,
      child: Container(
          width: double.infinity,
          height: context.watch<PodborkiItemPageModel>().getAnim * 75.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF8C84E2).withOpacity(
                    context.watch<PodborkiItemPageModel>().getAnim),
                const Color(0xFF6C689F).withOpacity(
                    context.watch<PodborkiItemPageModel>().getAnim),
              ],
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(40.0),
            ),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: context.watch<PodborkiItemPageModel>().getAnim * 50.0,
                height: context.watch<PodborkiItemPageModel>().getAnim * 50.0,
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
                      fontSize:
                          context.watch<PodborkiItemPageModel>().getAnim * 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  '----------------------------------',
                  style: TextStyle(
                      fontFamily: 'TTNorms',
                      fontSize:
                          context.watch<PodborkiItemPageModel>().getAnim * 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                Row(
                  children: [
                    Text(
                      '00:00',
                      style: TextStyle(
                          fontFamily: 'TTNorms',
                          fontSize:
                              context.watch<PodborkiItemPageModel>().getAnim *
                                  10.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: context.watch<PodborkiItemPageModel>().getAnim *
                          140.0,
                    ),
                    Text(
                      '00:00',
                      style: TextStyle(
                          fontFamily: 'TTNorms',
                          fontSize:
                              context.watch<PodborkiItemPageModel>().getAnim *
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
                    width:
                        context.watch<PodborkiItemPageModel>().getAnim * 24.0,
                    height:
                        context.watch<PodborkiItemPageModel>().getAnim * 24.0,
                  )),
            )
          ])),
    );
  }
}
