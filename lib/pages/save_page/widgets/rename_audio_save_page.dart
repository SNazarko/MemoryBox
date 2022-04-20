import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:provider/src/provider.dart';

import '../save_page_model.dart';

class RenameAudioSavePage extends StatelessWidget {
  RenameAudioSavePage({Key? key, required this.audioName}) : super(key: key);
  final String audioName;
  final Set _searchName = {};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.0,
      width: 200.0,
      child: TextField(
        maxLines: 1,
        autofocus: true,
        onChanged: (value) {
          if (value != '') {
            final data = value.toLowerCase();
            _searchName.add(data);
            if (data != _searchName.last) {
              _searchName.remove(_searchName.last);
            }
            context.read<SavePageModel>().setNewAudioName(value);
            context
                .read<SavePageModel>()
                .setNewSearchName(_searchName.toList());
          } else {
            context.read<SavePageModel>().setNewAudioName(audioName);
          }
        },
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14.0,
          color: AppColor.colorText,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: audioName,
          hintStyle: const TextStyle(
            fontSize: 14.0,
            color: AppColor.colorText,
          ),
        ),
      ),
    );
  }
}
