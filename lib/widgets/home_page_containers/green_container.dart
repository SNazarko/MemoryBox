import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/view_model.dart';
import '../../resources/app_colors.dart';

class GreenContainer extends StatelessWidget {
  const GreenContainer({Key? key, required this.screenWidth}) : super(key: key);
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 25.0,
            ),
            child: Text(
              'Здесь будет твой набор сказок',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40.0),
          TextButton(
            onPressed: () {
              Provider.of<Navigation>(context, listen: false).setCurrentIndex =
                  1;
            },
            child: const Text(
              'Добавить',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      width: screenWidth / 2.3,
      height: 210.0,
      decoration: const BoxDecoration(
          color: AppColor.green100,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          )),
    );
  }
}
