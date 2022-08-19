import 'package:fchat/CustomUI/avatar_card.dart';
import 'package:fchat/CustomUI/contact_card.dart';
import 'package:fchat/Model/chat_model.dart';
import 'package:flutter/material.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
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
  List<ChatModel> groupmembers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "New Group",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Add Participants",
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
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: contacts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  height: groupmembers.isNotEmpty ? 90 : 10,
                );
              } else {
                return InkWell(
                  onTap: () {
                    if (contacts[index - 1].select == true) {
                      setState(() {
                        groupmembers.remove(contacts[index - 1]);
                        contacts[index - 1].select = false;
                      });
                    } else {
                      setState(() {
                        groupmembers.add(contacts[index - 1]);
                        contacts[index - 1].select = true;
                      });
                    }
                  },
                  child: ContactCard(
                    contacts: contacts[index - 1],
                  ),
                );
              }
            },
          ),
          groupmembers.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      height: 75,
                      color: Colors.white,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            if (contacts[index].select == true) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    contacts[index].select == false;
                                    groupmembers.remove(contacts[index]);
                                  });
                                },
                                child: AvatarCard(
                                  contacts: contacts[index],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
