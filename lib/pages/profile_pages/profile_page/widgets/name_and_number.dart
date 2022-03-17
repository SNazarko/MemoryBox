import 'package:flutter/material.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/container_shadow.dart';
import 'package:provider/src/provider.dart';
import '../../../../models/user_model.dart';
import '../../../../repositories/user_repositories.dart';
import '../../profile_model.dart';

class NameAndNumber extends StatelessWidget {
  NameAndNumber({Key? key, required this.screenWidth}) : super(key: key);
  final UserRepositories repositories = UserRepositories();
  final double? screenWidth;

  Widget buildUser(UserModel model) => _NameNumberModel(
        name: '${model.displayName}',
        number: '${model.phoneNumb}',
        screenWidth: screenWidth!,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5.0,
        ),
        StreamBuilder<List<UserModel>>(
          stream: repositories.readUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Ошыбка');
            }
            if (snapshot.hasData) {
              final collections = snapshot.data!;
              return Container(
                child: collections.map(buildUser).toList().first,
              );
            } else {
              return SizedBox(
                width: screenWidth! / 2.3,
                height: 95.0,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class _NameNumberModel extends StatelessWidget {
  const _NameNumberModel(
      {Key? key,
      required this.name,
      required this.number,
      required this.screenWidth})
      : super(key: key);
  final String name;
  final String number;
  final double screenWidth;

  Widget nameWidget(BuildContext context) {
    if (name == 'Имя') {
      return Text(
        '${context.watch<DataModel>().getName}',
        style: kBodiTextStyle,
      );
    } else {
      return Text(
        name,
        style: kBodiTextStyle,
      );
    }
  }

  Widget numberWidget(BuildContext context) {
    if (name == '+00(000)0000000') {
      return Text(
        '${context.watch<DataModel>().getNumber}',
      );
    } else {
      return Text(
        number,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        nameWidget(context),
        const SizedBox(
          height: 10.0,
        ),
        ContainerShadow(
          image: const Text(''),
          width: screenWidth,
          height: 60.0,
          radius: 50.0,
          widget: numberWidget(context),
        ),
        const SizedBox(
          height: 15.0,
        )
      ],
    );
  }
}
