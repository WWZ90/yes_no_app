import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  const MessageFieldBox({super.key, required this.onValue});

  final ValueChanged<String> onValue;

  @override
  Widget build(t) {
    final textController = TextEditingController();
    final focusNode = FocusNode();

    final outlineInputBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(color: Colors.transparent),
    );

    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1),
      hintText: 'End your message with "?"',
      hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      suffixIcon: IconButton(
        onPressed: () {
          final textValue = textController.text.trim();
          if (textValue.isNotEmpty) {
            // Handle message send action
            onValue(textValue);
            textController.clear();
          }
        },
        icon: Icon(Icons.send, color: Colors.blue),
      ),
    );

    return TextFormField(
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
      controller: textController,
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        // Handle message send action
        onValue(value);
        textController.clear();
        focusNode.requestFocus();
      },
    );
  }
}
