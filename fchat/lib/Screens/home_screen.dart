import 'package:fchat/Model/chat_model.dart';
import 'package:fchat/pages/camera_page.dart';
import 'package:fchat/pages/chat_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.chatModels, this.sourceChat})
      : super(key: key);
  final List<ChatModel>? chatModels;
  final ChatModel? sourceChat;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FChat"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton<String>(onSelected: (value) {
            // print(value);
          }, itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: "New Group",
                child: Text("New Group"),
              ),
              PopupMenuItem(
                value: "New Broadcast",
                child: Text("New Broadcast"),
              ),
              PopupMenuItem(
                value: "FChat Web",
                child: Text("FChat Web"),
              ),
              PopupMenuItem(
                value: "Starred Messages",
                child: Text("Starred Masseges"),
              ),
              PopupMenuItem(
                value: "Settings",
                child: Text("Settings"),
              ),
            ];
          })
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(
                Icons.camera_alt,
              ),
            ),
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          CameraPage(),
          ChatPage(
            chatModels: widget.chatModels,
            sourceChat: widget.sourceChat,
          ),
          Text("Status"),
          Text("Calls"),
        ],
      ),
    );
  }
}
