import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/authorization_pages/registration_page/registration_page.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../Blocs/navigation_bloc/navigation__bloc.dart';
import '../../../Blocs/navigation_bloc/navigation__event.dart';
import '../../../Blocs/navigation_bloc/navigation__state.dart';
import '../../../widgets/navigation/navigate_to_page.dart';
import '../../audio_recordings_page/audio_recordings_page.dart';

class HomePageNotIsAuthorization extends StatelessWidget {
  const HomePageNotIsAuthorization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(0.0, -5.0),
                  blurRadius: 10.0,
                )
              ]),
          child: Container(
            decoration: kBorderContainer2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                  flex: 1,
                  child: _TitleAudioList(),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
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
                                              route:
                                                  RegistrationPage.routeName),
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TitleAudioList extends StatelessWidget {
  const _TitleAudioList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Аудиозаписи',
                style: TextStyle(fontSize: 24.0),
              ),
              GestureDetector(
                onTap: () => NavigateToPage.instance?.navigate(
                  context,
                  index: 3,
                  currentIndex: state.currentIndex,
                  route: AudioRecordingsPage.routeName,
                ),
                child: const Text(
                  'Открыть все',
                  style: TextStyle(fontSize: 14.0),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
