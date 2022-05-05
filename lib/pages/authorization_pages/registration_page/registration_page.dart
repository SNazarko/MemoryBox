import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/authorization_pages/registration_page/widget/auth_widget.dart';
import '../../../widgets/uncategorized/appbar/appbar_header_authorization.dart';
import 'bloc/authorization_bloc/app_authorization_bloc.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);
  static const routeName = '/registration_page';
  final PageController _controller = PageController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const AppbarHeaderAuthorization(
                title: 'Регистрация',
                subtitle: '',
              ),
              const SizedBox(
                height: 15.0,
              ),
              AuthWidget(
                controller: _controller,
                phoneController: phoneController,
                otpController: otpController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
