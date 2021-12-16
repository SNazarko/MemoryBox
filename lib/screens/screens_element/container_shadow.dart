import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ContainerShadow extends StatelessWidget {
  const ContainerShadow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 275,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0.0, 5.0),
              blurRadius: 5.0,
            )
          ]),
      child: Container(
        width: 275,
        height: 100,
        decoration: kBorderContainer,
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Регистрация привяжет твои сказки к облаку, после чего они всегда будут с тобой',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
