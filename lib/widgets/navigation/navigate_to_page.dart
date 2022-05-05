import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Blocs/navigation_bloc/navigation__bloc.dart';
import '../../Blocs/navigation_bloc/navigation__event.dart';

class NavigateToPage {
  NavigateToPage._();
  static NavigateToPage? _instance;

  static NavigateToPage? get instance {
    _instance ??= NavigateToPage._();
    return _instance;
  }

  void navigate(
    BuildContext context, {
    required int index,
    required int currentIndex,
    required String route,
  }) {
    Navigator.pop(context);

    if (index != currentIndex) {
      context.read<NavigationBloc>().add(
            NavigateMenu(
              menuIndex: index,
              route: route,
            ),
          );
    }
  }
}
