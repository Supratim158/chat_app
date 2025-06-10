import 'package:chatapp/customUi/custom_card.dart';
import 'package:chatapp/screens/contact_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/chat_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
        name: "Supratim",
        icon: "person.svg",
        isGroup: false,
        currentMessage: "Hi i am developing a chat app",
        time: "15:08"
    ),
    ChatModel(
        name: "Supratim Army",
        icon: "groups.svg",
        isGroup: true,
        currentMessage: "Hi i am developing a chat app",
        time: "15:08",

    ),

    ChatModel(
        name: "Tuplu",
        icon: "person.svg",
        isGroup: false,
        currentMessage: "Hi i am developing a chat app",
        time: "15:08",

    ),
    ChatModel(
        name: "Tuplu Army",
        icon: "groups.svg",
        isGroup: true,
        currentMessage: "Hi i am developing a chat app",
        time: "15:08",

    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ContactScreen()
              )
          );
        },
        child: Icon(CupertinoIcons.chat_bubble_text_fill, size: 30,),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => CustomCard(
            chatModel: chats[index]),
      ),
    );
  }
}
