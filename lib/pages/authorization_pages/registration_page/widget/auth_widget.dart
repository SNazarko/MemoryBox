import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/authorization_pages/registration_page/widget/text_field_captcha.dart';

import '../../../../repositories/auth_repositories.dart';
import '../../../../resources/app_colors.dart';
import '../../../../widgets/button/button_continue.dart';
import '../../../../widgets/uncategorized/container_shadow.dart';
import '../../../../widgets/uncategorized/textfield_input.dart';
import '../../../main_page.dart';
import '../../last_authorization_page.dart';
import '../bloc/authorization_bloc/app_authorization_bloc.dart';
import '../bloc/authorization_bloc/app_authorization_event.dart';
import '../bloc/authorization_bloc/app_authorization_state.dart';

class AuthWidget extends StatelessWidget {
  AuthWidget(
      {Key? key,
      required this.controller,
      required this.otpController,
      required this.phoneController})
      : super(key: key);
  PageController controller = PageController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController otpController = TextEditingController();

  void buttonContinue(BuildContext context, state) {
    if (phoneController.text.isNotEmpty && state.status == AuthStatus.initial) {
      FocusScope.of(context).unfocus();
      BlocProvider.of<AuthBloc>(context)
          .add(PhoneNumberVerificationIdEvent(phone: phoneController.text));
      controller.animateToPage(
        1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    } else if (state.status == AuthStatus.codeSent) {
      FocusScope.of(context).unfocus();
      BlocProvider.of<AuthBloc>(context).add(PhoneAuthCodeVerificationIdEvent(
          phone: phoneController.text,
          smsCode: otpController.text,
          verificationId: state.verificationId));
      if (AuthRepositories.instance.user != null) {
        Timer(
            const Duration(milliseconds: 0),
            () =>
                Navigator.pushNamed(context, LastAuthorizationPage.routeName));
      }
    } else if (state.status == AuthStatus.failed) {
      BlocProvider.of<AuthBloc>(context)
          .add(PhoneNumberVerificationIdEvent(phone: phoneController.text));
      controller.animateToPage(
        1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    } else if (state.status == AuthStatus.failedCodeSent) {
      BlocProvider.of<AuthBloc>(context)
          .add(PhoneNumberVerificationIdEvent(phone: phoneController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: context.watch<AuthBloc>(),
      listener: (_, state) {
        if (state.status == AuthStatus.logged) {
          controller.animateToPage(2,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            SizedBox(
              height: screenHeight - 350,
              width: screenWidth,
              child: PageView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _Phone(
                    phoneController: phoneController,
                  ),
                  _Sms(
                    otpController: otpController,
                    controller: controller,
                    phoneController: phoneController,
                  ),
                  const LastAuthorizationPage(),
                ],
              ),
            ),
            Positioned(
              top: 100.0,
              left: (screenWidth - 275) / 2,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  ButtonContinue(
                    onPressed: state.status == AuthStatus.loading
                        ? null
                        : () => buttonContinue(context, state),
                    text: state.status == AuthStatus.failed ||
                            state.status == AuthStatus.failedCodeSent
                        ? 'Отправить еще раз'
                        : 'Продолжыть',
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MainPage.routeName);
                      },
                      child: const Text(
                        'Позже',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: AppColor.colorText,
                        ),
                      )),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const ContainerShadow(
                    image: Text(''),
                    width: 275.0,
                    height: 100.0,
                    radius: 20.0,
                    widget: Text(
                      'Регистрация привяжет твои сказки к облаку, после чего они всегда будут с тобой',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class _Sms extends StatelessWidget {
  _Sms(
      {Key? key,
      required this.otpController,
      required this.controller,
      required this.phoneController})
      : super(key: key);
  TextEditingController otpController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          children: [
            state.status == AuthStatus.loading
                ? const Text(
                    'Регистрация телефона ...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                : const SizedBox.shrink(),
            state.status == AuthStatus.codeSent
                ? const Text(
                    'Введи код из смс, чтобы мы \n  тебя запомнили',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                : const SizedBox.shrink(),
            state.status == AuthStatus.failed
                ? const Text(
                    'Ошибка ввода номера',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                : const SizedBox.shrink(),
            state.status == AuthStatus.failedCodeSent
                ? const Text(
                    'Отправить смс еще раз',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 10.0,
            ),
            state.status == AuthStatus.loading
                ? const CircularProgressIndicator()
                : const SizedBox.shrink(),
            state.status == AuthStatus.codeSent
                ? TextFieldCaptcha(
                    controller: otpController,
                  )
                : const SizedBox.shrink(),
            state.status == AuthStatus.failed
                ? TextFieldInput(
                    controller: phoneController,
                  )
                : const SizedBox.shrink(),
            state.status == AuthStatus.failedCodeSent
                ? TextFieldCaptcha(
                    controller: otpController,
                  )
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}

class _Phone extends StatelessWidget {
  _Phone({Key? key, required this.phoneController}) : super(key: key);
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Введи номер телефона',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: TextFieldInput(
            controller: phoneController,
          ),
        ),
      ],
    );
  }
}