import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../Blocs/navigation_bloc/navigation__bloc.dart';
import '../../../Blocs/navigation_bloc/navigation__state.dart';
import '../../../models/view_model.dart';
import '../../../pages/collections_pages/collection/collection.dart';
import '../../../resources/app_colors.dart';
import '../../navigation/navigate_to_page.dart';

class GreenContainer extends StatelessWidget {
  const GreenContainer({Key? key, required this.screenWidth}) : super(key: key);
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
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
                onPressed: () => NavigateToPage.instance?.navigate(
                  context,
                  index: 1,
                  currentIndex: state.currentIndex,
                  route: Collections.routeName,
                ),
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
      },
    );
  }
}
