import 'package:chatapp/customUi/contact_card.dart';
import 'package:chatapp/model/chat_model.dart';
import 'package:chatapp/screens/new_group.dart';
import 'package:flutter/material.dart';

import '../customUi/button_card.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});



  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {

    List<ChatModel> contacts = [
      ChatModel(
        name: "Supratim",
        status: "Hi i am doing nothing"
      ),
      ChatModel(
          name: "Tuplu",
          status: "Hi i am doing nothing"
      ),
      ChatModel(
          name: "SM",
          status: "Hi i am doing nothing"
      ),
      ChatModel(
          name: "Tyson",
          status: "Hi i am doing nothing"
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Text(
              "158 Contacts",
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton<String>(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(child: Text("New group"), value: "New group"),
                  PopupMenuItem(child: Text("New group"), value: "New group"),
                  PopupMenuItem(child: Text("New group"), value: "New group"),
                  PopupMenuItem(child: Text("New group"), value: "New group"),
                ];
              })
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length+2,
          itemBuilder: (context, index){
          if (index == 0){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateGroup()));
              },
                child: ButtonCard(name: "New Group", icon: Icons.group_add_rounded));
          }
          else if (index == 1){
            return ButtonCard(name: "New Contact", icon: Icons.person_add);
          }

          return ContactCard(contact: contacts[index-2]);

          }


    )
    );
  }
}
