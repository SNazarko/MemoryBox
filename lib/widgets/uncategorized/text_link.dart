import 'package:flutter/cupertino.dart';
import 'package:memory_box/utils/constants.dart';

class TextLink extends StatelessWidget {
  const TextLink(
      {Key? key, required this.text, this.onPressed, this.underline = true})
      : super(key: key);
  final String text;
  final void Function()? onPressed;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: underline ? kBodi2TextStyle : kBodiOverlineTextStyle,
      ),
    );
  }
}
