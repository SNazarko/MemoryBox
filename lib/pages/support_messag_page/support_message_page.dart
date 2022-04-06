import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import '../../repositories/user_repositories.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../widgets/appbar_clipper.dart';

class SupportMessagePage extends StatelessWidget {
  SupportMessagePage({Key? key}) : super(key: key);
  static const routeName = '/support_message_page';
  final UserRepositories rep = UserRepositories();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Text(
          'Поддержка',
          style: kTitleTextStyle2,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                const AppbarMenuSupportMessagePage(),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 550.0,
                    width: screenWidth * 0.975,
                    decoration: kBorderContainer2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('SupportQuestions')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapshot.hasData) {
                                final message = snapshot.data!;
                                return Expanded(
                                  child: ListView(
                                    padding: const EdgeInsets.all(15.0),
                                    reverse: true,
                                    children: message.docs.reversed
                                        .map((DocumentSnapshot document) {
                                      Map<String, dynamic> data = document
                                          .data() as Map<String, dynamic>;
                                      final message = data['message'] ?? '';
                                      final phoneNumber =
                                          data['phoneNumber'] ?? '';
                                      final currentUser = rep.user!.phoneNumber;
                                      bool? isMe;
                                      if (currentUser == phoneNumber) {
                                        isMe = true;
                                      }
                                      if ('+38000112233' == phoneNumber) {
                                        isMe = false;
                                      }
                                      return ModelMessage(
                                        message: message,
                                        phoneNumber: phoneNumber,
                                      );
                                    }).toList(),
                                  ),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                        TextFieldSupport(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ModelMessage extends StatelessWidget {
  ModelMessage({
    Key? key,
    required this.message,
    required this.phoneNumber,
  }) : super(key: key);
  final UserRepositories rep = UserRepositories();
  final String? message;
  final String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    if (phoneNumber == rep.user!.phoneNumber) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            phoneNumber!,
            style: const TextStyle(fontSize: 12.0),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Material(
              elevation: 5.0,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50.0),
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  message!,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),
        ],
      );
    }
    if (phoneNumber == '+380001112233') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Поддержка',
            style: TextStyle(fontSize: 12.0),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Material(
              color: Colors.blueGrey.shade200,
              elevation: 5.0,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(50.0),
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  message!,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return const Text('Error');
  }
}

class TextFieldSupport extends StatelessWidget {
  TextFieldSupport({Key? key}) : super(key: key);
  final messageTextController = TextEditingController();
  UserRepositories repositories = UserRepositories();
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

class AppbarMenuSupportMessagePage extends StatelessWidget {
  const AppbarMenuSupportMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Stack(children: [
      Container(
        height: screenHeight / 1.27,
      ),
      ClipPath(
        clipper: AppbarClipper(),
        child: Container(
          color: AppColor.colorAppbar,
          width: double.infinity,
          height: 125.0,
        ),
      ),
    ]);
  }
}
