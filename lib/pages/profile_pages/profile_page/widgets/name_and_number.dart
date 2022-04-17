import 'package:flutter/material.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:memory_box/widgets/container_shadow.dart';
import 'package:provider/src/provider.dart';
import '../../../../models/user_model.dart';
import '../../../../repositories/user_repositories.dart';
import '../../profile_model.dart';

class NameAndNumber extends StatelessWidget {
  const NameAndNumber({Key? key, required this.screenWidth}) : super(key: key);
  final double? screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5.0,
        ),
        Text(
          '${context.watch<DataModel>().getName}',
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
            '${context.watch<DataModel>().getNumber}',
          ),
        ),
        const SizedBox(
          height: 15.0,
        )
      ],
    );
  }
}
