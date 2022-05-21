import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../repositories/collections_repositories.dart';
import '../../repositories/user_repositories.dart';

class AlertDialogApp {
  AlertDialogApp._();
  static final AlertDialogApp instance = AlertDialogApp._();
  void alertDone(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          Timer(const Duration(seconds: 1), () async {
            await UserRepositories.instance.updateTotalTimeQuality();
            Navigator.pop(context);
          });
          return AlertDialog(
            insetPadding: const EdgeInsets.all(75.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            content: Image.asset(
              AppIcons.tick,
              width: 175.0,
              height: 175.0,
            ),
          );
        });
  }

  void alertDialog(
    BuildContext context,
    String idAudio,
    String inCollection,
    String fromCollection,
  ) =>
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          title: const Text(
            'Подтверждаете удаление?',
            style: TextStyle(
              color: AppColor.pink,
              fontSize: 18.0,
            ),
          ),
          content: const Text(
            'Ваш файл перенесется в папку “Недавно удаленные”. Через 15 дней он исчезнет.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.colorText70,
              fontSize: 14.0,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  alertDone(context);
                  await CollectionsRepositories.instance.copyPastCollections(
                    idAudio,
                    fromCollection,
                    inCollection,
                  );
                  await CollectionsRepositories.instance
                      .deleteCollection(idAudio, fromCollection);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 15.0,
                  ),
                  child: Text(
                    'Да',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppColor.colorAppbar,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: const BorderSide(
                        color: AppColor.colorAppbar,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 50.0,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10.0,
                  ),
                  child: Text(
                    'Нет',
                    style: TextStyle(
                      color: AppColor.colorText,
                    ),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppColor.white100,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: const BorderSide(
                        color: AppColor.blue300,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  void alertDialogPermission(
          BuildContext context, String text, IconData icon) =>
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Flexible(
                flex: 4,
                child: Text(text),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                'Отключить',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text(
                'Настройки',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                ),
              ),
              onPressed: () => openAppSettings(),
            ),
          ],
        ),
      );
}
