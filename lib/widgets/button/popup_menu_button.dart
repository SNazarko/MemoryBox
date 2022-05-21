import 'package:flutter/material.dart';

PopupMenuItem popupMenuItem(
  String text,
  Function onTap,
) {
  return PopupMenuItem(
    onTap: () {
      onTap();
    },
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 14,
      ),
    ),
  );
}
