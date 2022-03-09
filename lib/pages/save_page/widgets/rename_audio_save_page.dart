import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:provider/src/provider.dart';

import '../save_page_model.dart';

class RenameAudioSavePage extends StatelessWidget {
  RenameAudioSavePage({Key? key}) : super(key: key);
  final Set searchName = {};

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
            searchName.add(data);
            if (data != searchName.last) {
              searchName.remove(searchName.last);
            }
            context.read<SavePageModel>().setNewAudioName(value);
            context.read<SavePageModel>().setSearchName(searchName.toList());
          } else {
            context.read<SavePageModel>().setNewAudioName(
                Provider.of<SavePageModel>(context, listen: false)
                    .getAudioName);
          }
        },
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14.0,
          color: AppColor.colorText,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText:
              '${Provider.of<SavePageModel>(context, listen: false).getAudioName}',
          hintStyle: const TextStyle(
            fontSize: 14.0,
            color: AppColor.colorText,
          ),
        ),
      ),
    );
  }
}
