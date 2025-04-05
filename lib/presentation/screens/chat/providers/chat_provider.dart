import 'package:flutter/widgets.dart';
import 'package:yes_no/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();

  List<Message> messages = [
    Message(text: 'Hola!', fromWho: FromWho.me),
    Message(text: 'Queria preguntarte algo', fromWho: FromWho.me),
  ];

  Future<void> sendMessage(String text) async {
    messages.add(Message(text: text, fromWho: FromWho.me));
    notifyListeners();

    if (text.endsWith('?')) {
      gerReply();
    }

    moveScrollToBottom();
  }

  Future<void> gerReply() async {
    final message = await GetYesNoAnswer().getAnswer();
    messages.add(message);
    notifyListeners();

    moveScrollToBottom();
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
