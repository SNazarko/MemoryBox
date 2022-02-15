import 'package:flutter/cupertino.dart';
import 'package:memory_box/resources/app_colors.dart';

class PodborkiItem extends StatelessWidget {
  PodborkiItem({Key? key, this.title, this.quality, this.image})
      : super(key: key);
  String? title;
  int? quality = 5;
  String? image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(20.0),
      ),
      child: SizedBox(
        width: 185.0,
        height: 250.0,
        child: Stack(
          children: [
            Image.network(
              image!,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 5, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: AppColor.white100,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '$quality аудио',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: AppColor.white100,
                          ),
                        ),
                        const Text(
                          '3:33 часа',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: AppColor.white100,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}