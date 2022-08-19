import 'package:fchat/Model/chat_model.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.contacts}) : super(key: key);
  final ChatModel contacts;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 50,
        width: 50,
        child: Stack(children: [
          CircleAvatar(
            backgroundColor: Colors.blueGrey[200],
            radius: 23,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
          ),
          contacts.select
              ? Positioned(
                  bottom: 4,
                  right: 5,
                  child: CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 11,
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                )
              : Container()
        ]),
      ),
      title: Text(
        contacts.name!,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        contacts.status!,
        style: TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }
}
