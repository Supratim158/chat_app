import 'package:chatapp/customUi/custom_card.dart';
import 'package:chatapp/screens/contact_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/chat_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.chatmodels,required this.sourcechat});
  final List<ChatModel> chatmodels;
  final ChatModel sourcechat;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {


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
        itemCount: widget.chatmodels.length,
        itemBuilder: (context, index) => CustomCard(
            chatModel: widget.chatmodels[index], sourcechat: widget.sourcechat,),
      ),
    );
  }
}
