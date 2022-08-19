import 'package:fchat/CustomUI/button_card.dart';
import 'package:fchat/CustomUI/contact_card.dart';
import 'package:fchat/Model/chat_model.dart';
import 'package:fchat/Screens/create_group.dart';
import 'package:flutter/material.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts = [
      ChatModel(name: "Nazmul Hassan", status: "Blazzing hot bro!"),
      ChatModel(name: "FAHIM Hassan", status: "Blazzing cold bro!"),
      ChatModel(name: "Nazmul Fahim", status: "Blazzing yo bro!"),
      ChatModel(name: "Niaz Hassan", status: "Blazzing no bro!"),
      ChatModel(name: "Farhan Hassan", status: "Blazzing fro bro!"),
      ChatModel(name: "Niaz Farhan", status: "Blazzing aha bro!"),
      ChatModel(name: "Nazmul Hassan", status: "Blazzing hot bro!"),
      ChatModel(name: "fAHIM Hassan", status: "Blazzing cold bro!"),
      ChatModel(name: "Nazmul Fahim", status: "Blazzing yo bro!"),
      ChatModel(name: "Niaz Hassan", status: "Blazzing no bro!"),
      ChatModel(name: "Farhan Hassan", status: "Blazzing fro bro!"),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Select Contact",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "270 Contacts available",
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 26,
            ),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: "Invite a Friend",
                  child: Text("Invite a Friend"),
                ),
                PopupMenuItem(
                  value: "Contacts",
                  child: Text("Contacts"),
                ),
                PopupMenuItem(
                  value: "Refresh",
                  child: Text("Refresh"),
                ),
                PopupMenuItem(
                  value: "Help",
                  child: Text("Help"),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateGroupPage()));
                },
                child: ButtonCard(name: "New Group", icon: Icons.group));
          } else if (index == 1) {
            return ButtonCard(name: "New Contact", icon: Icons.person_add);
          }
          return ContactCard(
            contacts: contacts[index - 2],
          );
        },
      ),
    );
  }
}
