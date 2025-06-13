
import 'package:flutter/material.dart';

import '../customUi/button_card.dart';
import '../model/chat_model.dart';
import 'home_screen.dart';

class LndingPage extends StatefulWidget {
  const LndingPage({super.key});

  @override
  _LndingPageState createState() => _LndingPageState();
}

class _LndingPageState extends State<LndingPage> {
  late ChatModel sourcechat;
  List<ChatModel> chatmodels = [
    ChatModel(
      name: "Dev Stack",
      isGroup: false,
      currentMessage: "Hi Everyone",
      time: "4:00",
      icon: "person.svg",
      id: 1,
    ),
    ChatModel(
      name: "Kishor",
      isGroup: false,
      currentMessage: "Hi Kishor",
      time: "13:00",
      icon: "person.svg",
      id: 2,
    ),

    ChatModel(
      name: "Collins",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "8:00",
      icon: "person.svg",
      id: 3,
    ),

    ChatModel(
      name: "Balram Rathore",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "2:00",
      icon: "person.svg",
      id: 4,
    ),

    // ChatModel(
    //   name: "NodeJs Group",
    //   isGroup: true,
    //   currentMessage: "New NodejS Post",
    //   time: "2:00",
    //   icon: "group.svg",
    // ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chatmodels.length,
          itemBuilder: (contex, index) => InkWell(
            onTap: () {
              sourcechat = chatmodels.removeAt(index);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => HomeScreen(
                        chatmodels: chatmodels,
                        sourcechat: sourcechat,
                      )));
            },
            child: ButtonCard(
              name: chatmodels[index].name!,
              icon: Icons.person,
            ),
          )),
    );
  }
}



