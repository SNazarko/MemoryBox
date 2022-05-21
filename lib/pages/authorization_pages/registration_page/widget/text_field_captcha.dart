import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';

class TextFieldCaptcha extends StatelessWidget {
  const TextFieldCaptcha({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 275.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(30.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0.0, 5.0),
            blurRadius: 5.0,
          )
        ],
      ),
      child: TextField(
        autofocus: true,
        inputFormatters: [
          MaskedInputFormatter(
            '######',
          ),
        ],
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(
            color: Colors.black,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
