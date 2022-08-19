import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:fchat/CustomUI/own_message_card.dart';
import 'package:fchat/CustomUI/reply_card.dart';
import 'package:fchat/Model/chat_model.dart';
import 'package:fchat/Model/message_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualChatPage extends StatefulWidget {
  const IndividualChatPage({Key? key, required this.chatModel, this.sourceChat})
      : super(key: key);
  final ChatModel chatModel;
  final ChatModel? sourceChat;

  @override
  State<IndividualChatPage> createState() => _IndividualChatPageState();
}

class _IndividualChatPageState extends State<IndividualChatPage> {
  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;
  late IO.Socket socket;
  bool sendButton = false;
  final List<MessageModel> messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _connect();
  }

  _onEmojiSelected(Emoji emoji) {
    emojiShowing = false;
  }

  _onBackspacePressed() {
    // print('_onBackspacePressed');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _connect() {
    socket = IO.io("http://192.168.132.117:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        _setMessage("destination", msg["message"]);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print(socket.connected);
    socket.emit(
      "signin",
      widget.sourceChat!.id,
    );
  }

  void _sendMessage(String message, int sourceId, int targetId) {
    _setMessage("source", message);
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
    });
  }

  void _setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/chatbackground.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leadingWidth: 70,
            titleSpacing: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blueGrey,
                    child: Icon(
                      widget.chatModel.isGroup! ? Icons.groups : Icons.person,
                      size: 36,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatModel.name!,
                      style: TextStyle(
                          fontSize: 18.5, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Last seen today at 12:15am",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.videocam),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.call),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  // print(value);
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: "View Contact",
                      child: Text("View Contact"),
                    ),
                    PopupMenuItem(
                      value: "Media, links and Docs",
                      child: Text("Media, links, and Docs"),
                    ),
                    PopupMenuItem(
                      value: "Search",
                      child: Text("Search"),
                    ),
                    PopupMenuItem(
                      value: "Wallpaper",
                      child: Text("Wallpaper"),
                    ),
                    PopupMenuItem(
                      value: "More",
                      child: Text("More"),
                    ),
                  ];
                },
              ),
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                children: [
                  Expanded(
                    // height: MediaQuery.of(context).size.height - 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(height: 70);
                        }
                        if (messages[index].type == "source") {
                          return OwnMessageCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        } else {
                          return ReplyCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                  margin: EdgeInsets.only(
                                      left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: TextFormField(
                                    controller: _controller,
                                    onTap: () {
                                      setState(() {
                                        emojiShowing = false;
                                      });
                                    },
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type a message",
                                      prefixIcon: IconButton(
                                        icon: Icon(
                                          Icons.emoji_emotions,
                                        ),
                                        onPressed: () {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          setState(() {
                                            emojiShowing = !emojiShowing;
                                          });
                                        },
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (builder) =>
                                                      _bottomSheet());
                                            },
                                            icon: Icon(
                                              Icons.attach_file,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.camera_alt,
                                            ),
                                          ),
                                        ],
                                      ),
                                      contentPadding: EdgeInsets.all(5),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8, right: 5, left: 2),
                                child: CircleAvatar(
                                  backgroundColor: Color(0xFF128C7E),
                                  radius: 25,
                                  child: IconButton(
                                    icon: Icon(
                                        sendButton ? Icons.send : Icons.mic,
                                        color: Colors.white),
                                    onPressed: () {
                                      if (sendButton) {
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut);
                                        _sendMessage(
                                            _controller.text,
                                            widget.sourceChat!.id!,
                                            widget.chatModel.id!);
                                        _controller.clear();
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Offstage(
                            offstage: !emojiShowing,
                            child: SizedBox(
                              height: 250,
                              child: EmojiPicker(
                                  textEditingController: _controller,
                                  onEmojiSelected:
                                      (Category category, Emoji emoji) {
                                    _onEmojiSelected(emoji);
                                  },
                                  onBackspacePressed: _onBackspacePressed,
                                  config: Config(
                                      columns: 7,
                                      // Issue: https://github.com/flutter/flutter/issues/28894
                                      emojiSizeMax:
                                          32 * (Platform.isIOS ? 1.30 : .8),
                                      verticalSpacing: 0,
                                      horizontalSpacing: 0,
                                      gridPadding: EdgeInsets.zero,
                                      initCategory: Category.RECENT,
                                      bgColor: const Color(0xFFF2F2F2),
                                      indicatorColor: Colors.blue,
                                      iconColor: Colors.grey,
                                      iconColorSelected: Colors.blue,
                                      progressIndicatorColor: Colors.blue,
                                      backspaceColor: Colors.blue,
                                      skinToneDialogBgColor: Colors.white,
                                      skinToneIndicatorColor: Colors.grey,
                                      enableSkinTones: true,
                                      showRecentsTab: true,
                                      recentsLimit: 28,
                                      replaceEmojiOnLimitExceed: false,
                                      noRecents: const Text(
                                        'No Recents',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black26),
                                        textAlign: TextAlign.center,
                                      ),
                                      tabIndicatorAnimDuration:
                                          kTabScrollDuration,
                                      categoryIcons: const CategoryIcons(),
                                      buttonMode: ButtonMode.MATERIAL)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onWillPop: () {
                if (emojiShowing) {
                  emojiShowing = false;
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _bsIcons(IconData icon, String label, Color bgColor) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: bgColor,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomSheet() {
    return SizedBox(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _bsIcons(Icons.insert_drive_file, "Document", Colors.indigo),
                  SizedBox(width: 40),
                  _bsIcons(Icons.camera_alt, "Camera", Colors.pink),
                  SizedBox(width: 40),
                  _bsIcons(Icons.insert_photo, "Gallery", Colors.purple),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _bsIcons(Icons.headset, "Audio", Colors.orange),
                  SizedBox(width: 40),
                  _bsIcons(Icons.location_pin, "Location", Colors.teal),
                  SizedBox(width: 40),
                  _bsIcons(Icons.person, "Contact", Colors.blue),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
