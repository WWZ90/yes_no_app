import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no/domain/entities/message.dart';
import 'package:yes_no/presentation/screens/chat/providers/chat_provider.dart';
import 'package:yes_no/presentation/screens/chat/widgets/chat/her_message_bubble.dart';
import 'package:yes_no/presentation/screens/chat/widgets/chat/my_message_bubble.dart';
import 'package:yes_no/presentation/screens/chat/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://m.media-amazon.com/images/M/MV5BOTU3NDE5MDQ4MV5BMl5BanBnXkFtZTgwMzE5ODQ3MDI@._V1_FMjpg_UX1000_.jpg',
            ),
          ),
        ),
        title: const Text('Jennifer'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final messages = Provider.of<ChatProvider>(context).messages;
    final chatProvider = context.watch<ChatProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chatProvider.messages.length,
                controller: chatProvider.chatScrollController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final message = chatProvider.messages[index];
                  if (message.fromWho == FromWho.me) {
                    return MyMessageBubble(message: message);
                  } else {
                    return HerMessageBubble(message: message);
                  }
                },
              ),
            ),
            MessageFieldBox(onValue: chatProvider.sendMessage),
          ],
        ),
      ),
    );
  }
}
