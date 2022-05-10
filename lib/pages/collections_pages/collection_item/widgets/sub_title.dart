import 'package:flutter/cupertino.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/utils/constants.dart';

class SubTitle extends StatefulWidget {
  const SubTitle({Key? key, required this.subTitleCollection})
      : super(key: key);
  final String subTitleCollection;
  @override
  State<SubTitle> createState() => _SubTitleState();
}

class _SubTitleState extends State<SubTitle> {
  bool allText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15.0,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 28.0,
          ),
          child: Text(widget.subTitleCollection,
              style: kBodi2TextStyle,
              maxLines: allText ? 4 : 100,
              overflow: TextOverflow.ellipsis),
        ),
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              allText = !allText;
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                allText ? 'Подробнее' : 'Скрить...',
                style: const TextStyle(
                    color: AppColor.colorText50, fontSize: 13.0),
              ),
            ),
          ),
        )
      ],
    );
  }
}
