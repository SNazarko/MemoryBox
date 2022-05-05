import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/authorization_pages/registration_page/widget/text_field_captcha.dart';

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
    if (phoneController.text.isNotEmpty && state is AuthInitialState) {
      BlocProvider.of<AuthBloc>(context)
          .add(PhoneNumberVerificationIdEvent(phone: phoneController.text));
      controller.animateToPage(
        1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    } else if (state is CodeSendState) {
      BlocProvider.of<AuthBloc>(context).add(PhoneAuthCodeVerificationIdEvent(
          phone: phoneController.text,
          smsCode: otpController.text,
          verificationId: state.verificationId));
      Timer(const Duration(milliseconds: 1), () {
        Navigator.pushNamed(context, LastAuthorizationPage.routeName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: context.watch<AuthBloc>(),
      listener: (_, state) {
        if (state is LoggedInState) {
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
                    onPressed: state is LoadingAuthState
                        ? null
                        : () => buttonContinue(context, state),
                    text: 'Продолжыть',
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
  _Sms({
    Key? key,
    required this.otpController,
  }) : super(key: key);
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (_, state) {},
      builder: (context, state) {
        return Column(
          children: [
            state is LoadingAuthState
                ? const Text(
                    'Мы вас щас регистрируем ...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                : const SizedBox.shrink(),
            state is CodeSendState
                ? const Text(
                    'Введи код из смс, чтобы мы \n  тебя запомнили',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 10.0,
            ),
            state is LoadingAuthState
                ? const CircularProgressIndicator()
                : const SizedBox.shrink(),
            state is CodeSendState
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
            )),
      ],
    );
  }
}
