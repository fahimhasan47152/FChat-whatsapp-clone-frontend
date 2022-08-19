import 'package:fchat/CustomUI/button_card.dart';
import 'package:fchat/Model/chat_model.dart';
import 'package:fchat/Screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chatModels = [
    ChatModel(
        id: 1,
        name: "Fahim",
        isGroup: false,
        currentMessage: "Hi Fahim",
        time: "10:00pm",
        icon: "person"),
    ChatModel(
        id: 2,
        name: "Nazmul",
        isGroup: false,
        currentMessage: "Hi Nazmul",
        time: "11:00pm",
        icon: "person"),
    ChatModel(
        id: 4,
        name: "Coder",
        isGroup: false,
        currentMessage: "Hi Fahim",
        time: "8:00pm",
        icon: "groups"),
    ChatModel(
        id: 3,
        name: "Farhan",
        isGroup: false,
        currentMessage: "Hi Brother",
        time: "10:00pm",
        icon: "person"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatModels.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            sourceChat = chatModels.removeAt(index);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (builder) => HomeScreen(
                  chatModels: chatModels,
                  sourceChat: sourceChat,
                ),
              ),
            );
          },
          child: (ButtonCard(
            name: chatModels[index].name,
            icon: Icons.person,
          )),
        ),
      ),
    );
  }
}
