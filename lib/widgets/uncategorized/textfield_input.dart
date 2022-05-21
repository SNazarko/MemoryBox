import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    Key? key,
    this.onChanged,
    this.controller,
  }) : super(key: key);
  final void Function(String)? onChanged;
  final TextEditingController? controller;

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
        controller: controller,
        inputFormatters: [
          MaskedInputFormatter('+##(###) ## ## ###'),
        ],
        keyboardType: TextInputType.phone,
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
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
