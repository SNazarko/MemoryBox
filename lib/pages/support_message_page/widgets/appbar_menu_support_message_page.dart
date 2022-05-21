import 'package:flutter/cupertino.dart';
import '../../../resources/app_colors.dart';
import '../../../widgets/uncategorized/appbar_clipper.dart';

class AppbarMenuSupportMessagePage extends StatelessWidget {
  const AppbarMenuSupportMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          height: screenHeight / 1.27,
        ),
        ClipPath(
          clipper: AppbarClipper(),
          child: Container(
            color: AppColor.colorAppbar,
            width: double.infinity,
            height: 125.0,
          ),
        ),
      ],
    );
  }
}
