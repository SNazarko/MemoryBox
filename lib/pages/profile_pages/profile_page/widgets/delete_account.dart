import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:memory_box/database/preferences_data_model_user.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';

class DeleteAccount extends StatelessWidget {
  DeleteAccount({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;

  void _deleteAccount(BuildContext context) {
    Navigator.pop(context);
    UserRepositories.instance.deleteAccount();
    PreferencesDataUser.instance.cleanKey();
    _auth.signOut();
    Phoenix.rebirth(context);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            'Tочно удалить аккаунт?',
            style: TextStyle(color: AppColor.colorText, fontSize: 20.0),
          ),
          content: const Text(
            'Все аудиофайлы исчезнут и восстановить аккаунт будет невозможно',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.colorText50, fontSize: 14.0),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => _deleteAccount(context),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Text(
                  'Удалить',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColor.pink),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: const BorderSide(
                      color: AppColor.pink,
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
      ),
      child: const Text(
        'Удалить аккаунт',
        style: TextStyle(
          fontSize: 14.0,
          color: AppColor.pink,
        ),
      ),
    );
  }
}
