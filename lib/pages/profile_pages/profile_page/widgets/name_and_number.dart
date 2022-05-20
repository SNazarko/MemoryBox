import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:memory_box/widgets/uncategorized/container_shadow.dart';
import 'package:provider/src/provider.dart';
import '../blocs/profile_page/profile_page_bloc.dart';
import '../profile_model.dart';

class NameAndNumber extends StatelessWidget {
  const NameAndNumber({Key? key, required this.screenWidth}) : super(key: key);
  final double? screenWidth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(
              height: 5.0,
            ),
            Text(
              '${state.name}',
              style: kBodiTextStyle,
            ),
            const SizedBox(
              height: 10.0,
            ),
            ContainerShadow(
              image: const Text(''),
              width: screenWidth!,
              height: 60.0,
              radius: 50.0,
              widget: Text(
                '${state.number}',
              ),
            ),
            const SizedBox(
              height: 15.0,
            )
          ],
        );
      },
    );
  }
}
