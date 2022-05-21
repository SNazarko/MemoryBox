import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/repositories/auth_repositories.dart';
import '../bloc/support_message/support_message_bloc.dart';

class SupportMessagePageList extends StatelessWidget {
  const SupportMessagePageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupportMessageBloc, SupportMessageState>(
      builder: (context, state) {
        if (state.status == SupportMessageStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == SupportMessageStatus.success) {
          return Expanded(
            child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(15.0),
                itemCount: state.list.length,
                itemBuilder: (BuildContext context, int index) {
                  final message = state.list[index];
                  final currentUser =
                      AuthRepositories.instance.user!.phoneNumber;
                  bool? isMe;
                  if (currentUser == message.phoneNumber) {
                    isMe = true;
                  }
                  if ('+38000112233' == message.phoneNumber) {
                    isMe = false;
                  }
                  return _ModelMessage(
                      message: message.message,
                      phoneNumber: message.phoneNumber,
                      isMe: isMe ?? false);
                }),
          );
        }
        if (state.status == SupportMessageStatus.failed) {
          return const Center(
            child: Text('Ой: сталася помилка!'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
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
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Text(
            phoneNumber!,
            style: const TextStyle(
              fontSize: 12.0,
            ),
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
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
