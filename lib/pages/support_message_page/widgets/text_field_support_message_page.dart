import 'package:flutter/material.dart';
import '../../../repositories/user_repositories.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';

class TextFieldSupportMessagePage extends StatelessWidget {
  TextFieldSupportMessagePage({Key? key}) : super(key: key);
  final messageTextController = TextEditingController();
  final UserRepositories repositories = UserRepositories();
  String? message;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 6,
          child: TextField(
            controller: messageTextController,
            onTap: () {
              repositories.supportQuestions(message!);
              messageTextController.clear();
            },
            onChanged: (newMessage) {
              var messageTrim = newMessage.trim();
              message = messageTrim;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: GestureDetector(
              onTap: () {
                repositories.supportQuestions(message!);
                messageTextController.clear();
              },
              child: Container(
                height: 60.0,
                width: 55.0,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.colorAppbar),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
                child: const Center(
                    child: Text(
                  'Ввод',
                  style: kBodi2TextStyle,
                )),
              ),
            ),
          ),
        )
      ],
    );
  }
}
