import 'package:flutter/material.dart';
import 'package:memory_box/pages/authorization_pages/first_authorization_page.dart';
import 'package:memory_box/pages/authorization_pages/first_page.dart';
import 'package:memory_box/repositories/user_repositories.dart';

class InitializerWidget extends StatelessWidget {
  InitializerWidget({Key? key}) : super(key: key);
  static const routeName = '/initializer_widget';
  static const List<String> _pages = [
    FirstPage.routeName,
    FirstAuthorizationPage.routeName,
  ];

  final UserRepositories rep = UserRepositories();
  final isLoading = false;
  static Widget create() {
    return InitializerWidget();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : rep.user == null
            ? FirstPage.create()
            : FirstAuthorizationPage.create();
  }
}
