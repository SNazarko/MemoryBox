import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Blocs/navigation_bloc/navigation__bloc.dart';
import '../../../../Blocs/navigation_bloc/navigation__state.dart';
import '../../../../resources/app_colors.dart';
import '../../../../widgets/navigation/navigate_to_page.dart';
import '../../../authorization_pages/registration_page/registration_page.dart';

class ListCollectionsNotAuthorization extends StatelessWidget {
  const ListCollectionsNotAuthorization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(
              height: 250.0,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 50.0,
                  horizontal: 40.0,
                ),
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                          text: '     Для открытия полного \n '
                              '            функционала \n '
                              '   приложения вам нужно \n '
                              ' зарегистрироваться',
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: AppColor.colorText50,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => NavigateToPage.instance
                                    ?.navigate(context,
                                        index: 9,
                                        currentIndex: state.currentIndex,
                                        route: RegistrationPage.routeName),
                              text: ' здесь',
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: AppColor.pink,
                              ),
                            )
                          ]),
                    )
                  ],
                )),
          ],
        );
      },
    );
  }
}
