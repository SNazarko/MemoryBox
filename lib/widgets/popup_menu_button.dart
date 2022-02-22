import 'package:flutter/material.dart';

PopupMenuItem popupMenuItem(
  String text,
  Function onTap,
    int val,
) {
  return PopupMenuItem(
    onTap: () {
      onTap();
    },
    value: val,
    child: Text(
      text,
      style: const TextStyle(fontSize: 14),
    ),
  );
}
