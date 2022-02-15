import 'package:flutter/cupertino.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/constants.dart';

class SubTitle extends StatefulWidget {
  SubTitle({Key? key}) : super(key: key);

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
          child: Text(
              'Сказка о маленьком принце. Он родился в старой деревне и задавался всего-лишь '
              'одним вопросом - “Кто я такой?”. Он познакомился со старенькой бабушкой, '
              'которая рассказала ему легенду о малыше Кокки...',
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
