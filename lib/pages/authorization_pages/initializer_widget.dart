import 'package:flutter/material.dart';
import 'package:memory_box/pages/authorization_pages/first_authorization_page.dart';
import 'package:memory_box/pages/authorization_pages/first_page.dart';
import 'package:memory_box/repositories/auth_repositories.dart';

class InitializerWidget extends StatelessWidget {
  const InitializerWidget({Key? key}) : super(key: key);
  static const routeName = '/initializer_widget';
  final isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : AuthRepositories.instance!.user == null
            ? FirstPage.create()
            : FirstAuthorizationPage.create();
  }
}
