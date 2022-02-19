import 'package:flutter/cupertino.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/container_shadow.dart';
import 'package:provider/src/provider.dart';

import '../../data_model_user.dart';

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
          widget: Text('${context.watch<DataModel>().getNumber}'),
        ),
        const SizedBox(
          height: 15.0,
        )
      ],
    );
  }
}
