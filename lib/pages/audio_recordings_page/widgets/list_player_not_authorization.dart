import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import '../../../resources/app_colors.dart';
import '../../authorization_page/registration_page/registration_page.dart';

class ListPlayerNotAuthorization extends StatelessWidget {
  const ListPlayerNotAuthorization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 200.0,
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
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, RegistrationPage.routeName);
                            },
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
  }
}
