import 'package:fchat/CustomUI/custom_card.dart';
import 'package:fchat/Model/chat_model.dart';
import 'package:fchat/Screens/select_contact.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, this.chatModels, this.sourceChat})
      : super(key: key);
  final List<ChatModel>? chatModels;
  final ChatModel? sourceChat;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SelectContact()));
        },
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: widget.chatModels!.length,
        itemBuilder: (context, index) => CustomCard(
          chatModel: widget.chatModels![index],
          sourceChat: widget.sourceChat,
        ),
      ),
    );
  }
}
