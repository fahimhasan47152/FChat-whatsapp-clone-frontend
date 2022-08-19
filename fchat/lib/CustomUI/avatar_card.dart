import 'package:fchat/Model/chat_model.dart';
import 'package:flutter/material.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({Key? key, required this.contacts}) : super(key: key);
  final ChatModel contacts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueGrey[200],
              radius: 23,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 30,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 11,
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          contacts.name!,
          style: TextStyle(fontSize: 12),
        ),
      ]),
    );
  }
}
