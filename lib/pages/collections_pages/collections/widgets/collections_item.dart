import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collections_item/collections_item_page.dart';
import 'package:memory_box/pages/collections_pages/collections_item/collections_item_page_model.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:provider/provider.dart';

class CollectionsItem extends StatelessWidget {
  const CollectionsItem(
      {Key? key,
      this.title,
      this.quality,
      this.image,
      this.subTitle,
      this.data})
      : super(key: key);
  final String? title;
  final String? subTitle;
  final String? quality;
  final String? image;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(20.0),
      ),
      child: GestureDetector(
        onTap: () {
          context.read<CollectionsItemPageModel>().setTitle(title!);
          context.read<CollectionsItemPageModel>().setSubTitle(subTitle!);
          context.read<CollectionsItemPageModel>().setPhoto(image!);
          context.read<CollectionsItemPageModel>().setData(data!);
          context.read<CollectionsItemPageModel>().setQuality(quality!);
          Navigator.pushNamed(
            context,
            CollectionsItemPage.routeName,
          );
        },
        child: SizedBox(
          width: 185.0,
          height: 250.0,
          child: Stack(
            children: [
              image != ''
                  ? Image.network(
                      image!,
                      fit: BoxFit.fill,
                      width: 185.0,
                      height: 250.0,
                    )
                  : const ColoredBox(color: Colors.cyan),
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
      ),
    );
  }
}
