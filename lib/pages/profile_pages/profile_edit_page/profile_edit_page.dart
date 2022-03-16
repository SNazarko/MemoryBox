import 'package:flutter/material.dart';
import 'package:memory_box/pages/profile_pages/profile_edit_page/widgets/appbar_header_profile_edit.dart';
import 'package:memory_box/pages/profile_pages/profile_edit_page/widgets/photo_profile_edit.dart';
import 'package:memory_box/pages/profile_pages/profile_model.dart';
import 'package:memory_box/repositories/preferences_data_model_user.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/textfield_input.dart';
import 'package:provider/provider.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({Key? key}) : super(key: key);
  static const routeName = '/profile_edit';

  static Widget create() {
    return const ProfileEdit();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Stack(
                  children: const [
                    AppbarHeaderProfileEdit(),
                    PhotoProfileEdit(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const _TextFieldName(),
                    const _TextFieldNumber(),
                    _SaveButton()
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

class _TextFieldName extends StatelessWidget {
  const _TextFieldName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40.0,
        ),
        SizedBox(
          width: 200.0,
          height: 40.0,
          child: TextField(
            onChanged: (userName) {
              context.read<DataModel>().userName(userName);
            },
            style: const TextStyle(fontSize: 24.0),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _TextFieldNumber extends StatelessWidget {
  const _TextFieldNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 80.0,
        ),
        TextFieldInput(
          onChanged: (userNumber) {
            context.read<DataModel>().userNumber(userNumber);
          },
        ),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  _SaveButton({Key? key}) : super(key: key);
  final PreferencesDataUser _preferencesDataUser = PreferencesDataUser();
  final UserRepositories _repositories = UserRepositories();

  Future<void> saveUser(BuildContext context) async {
    Navigator.pop(context);
    final String name = Provider.of<DataModel>(context, listen: false).getName!;
    _preferencesDataUser.saveName(name);
    final String number =
        Provider.of<DataModel>(context, listen: false).getNumber!;
    _preferencesDataUser.saveNumber(number);
    // _repositories.updateName(name);
    // _repositories.updateNumber(number);
    _repositories.updateNameNumber(name, number);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20.0,
        ),
        TextButton(
            onPressed: () {
              saveUser(context);
            },
            child: const Text(
              'Сохранить',
              style: TextStyle(fontSize: 14, color: AppColor.colorText),
            ))
      ],
    );
  }
}
