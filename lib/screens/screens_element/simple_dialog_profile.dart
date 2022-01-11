import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpledDialogProfile extends StatelessWidget {
  const SimpledDialogProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select assignment'),
    );
  }
}
