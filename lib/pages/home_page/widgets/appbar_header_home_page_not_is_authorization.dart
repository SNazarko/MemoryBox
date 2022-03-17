import 'package:flutter/material.dart';
import 'package:memory_box/models/view_model.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:provider/src/provider.dart';
import '../../../widgets/home_page_containers/blue_container.dart';
import '../../../widgets/home_page_containers/green_container.dart';
import '../../../widgets/home_page_containers/orange_container.dart';

class AppbarHeaderHomePageNotIsAuthorization extends StatelessWidget {
  const AppbarHeaderHomePageNotIsAuthorization({Key? key}) : super(key: key);
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
          Positioned(
            top: 30.0,
            left: 16.0,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                right: 16.0,
              ),
              child: GreenContainer(
                screenWidth: screenWidth,
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                right: 16.0,
              ),
              child: OrangeContainer(
                screenWidth: screenWidth,
              ),
            ),
          ),
          Positioned(
            top: 135.0,
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 16.0,
                top: 24.0,
              ),
              child: BlueContainer(
                screenWidth: screenWidth,
              ),
            ),
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
