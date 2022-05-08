import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/repositories/auth_repositories.dart';
import '../../../repositories/user_repositories.dart';

class SupportMessagePageList extends StatelessWidget {
  const SupportMessagePageList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('SupportQuestions')
            .orderBy('dateTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
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
                children: message.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  final message = data['message'] ?? '';
                  final phoneNumber = data['phoneNumber'] ?? '';
                  final currentUser =
                      AuthRepositories.instance!.user!.phoneNumber;
                  bool? isMe;
                  if (currentUser == phoneNumber) {
                    isMe = true;
                  }
                  if ('+38000112233' == phoneNumber) {
                    isMe = false;
                  }
                  return _ModelMessage(
                      message: message,
                      phoneNumber: phoneNumber,
                      isMe: isMe ?? false);
                }).toList(),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class _ModelMessage extends StatelessWidget {
  _ModelMessage({
    Key? key,
    required this.message,
    required this.phoneNumber,
    required this.isMe,
  }) : super(key: key);
  final String? message;
  String? phoneNumber;
  final bool? isMe;

  @override
  Widget build(BuildContext context) {
    if (phoneNumber == '+380001112233') {
      phoneNumber = 'Поддержка';
    }
    return Column(
      crossAxisAlignment:
          isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            phoneNumber!,
            style: const TextStyle(fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Material(
            color: isMe! ? Colors.blue.shade100 : Colors.grey.shade200,
            elevation: 3.0,
            borderRadius: isMe!
                ? const BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  )
                : const BorderRadius.only(
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
}
