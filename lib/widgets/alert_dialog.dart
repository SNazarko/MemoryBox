import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';

import '../repositories/collections_repositories.dart';

class AlertDialogApp {
  AlertDialogApp({Key? key});
  final CollectionsRepositories repositoriesCollection =
      CollectionsRepositories();
  void alertDone(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          Timer(const Duration(seconds: 3), () {
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
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            'Подтверждаете удаление?',
            style: TextStyle(color: AppColor.pink, fontSize: 18.0),
          ),
          content: const Text(
            'Ваш файл перенесется в папку “Недавно удаленные”. Через 15 дней он исчезнет.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.colorText70, fontSize: 14.0),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await repositoriesCollection.copyPastCollections(
                    idAudio,
                    fromCollection,
                    inCollection,
                  );
                  await repositoriesCollection.deleteCollection(
                      idAudio, fromCollection);

                  alertDone(context);
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  child: Text(
                    'Да',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColor.colorAppbar),
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
              padding: const EdgeInsets.only(right: 50.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: Text(
                    'Нет',
                    style: TextStyle(color: AppColor.colorText),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColor.white100),
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
}
