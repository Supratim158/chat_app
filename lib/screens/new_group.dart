import 'package:chatapp/customUi/avatar_card.dart';
import 'package:chatapp/customUi/contact_card.dart';
import 'package:chatapp/model/chat_model.dart';
import 'package:flutter/material.dart';

import '../customUi/button_card.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});



  @override
  State<CreateGroup> createState() => _CreateGroupState();
}
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

List<ChatModel> groups = [];

class _CreateGroupState extends State<CreateGroup> {
  @override
  Widget build(BuildContext context) {



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
                "New Group",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                "Add Participants",
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ],
        ),
        body: Stack(
          children: [
            ListView.builder(
                itemCount: contacts.length + 1,
                itemBuilder: (context, index){

                  if (index==0){
                    return Container(
                      height: groups.length > 0 ?100:10,
                    );
                  }

                  return InkWell(
                    onTap: (){
                      if(contacts[index-1].select == false){
                        setState(() {
                          contacts[index-1].select = true;
                          groups.add(contacts[index-1]);
                        });
                      }
                      else{
                        setState(() {
                          contacts[index-1].select = false;
                          groups.remove(contacts[index-1]);
                        });
                      }
                    },
                      child: ContactCard(contact: contacts[index-1]));

                }


            ),

            groups.length > 0 ? Column(
              children: [
                Container(
                  height: 90,
                  color: Colors.white,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: contacts.length,
                      itemBuilder: (context,index){
                        if (contacts[index].select==true){
                          return InkWell(
                            onTap: (){
                              setState(() {
                                groups.remove(contacts[index]);
                                contacts[index].select = false;
                              });
                            },
                              child: AvatarCard(contact: contacts[index],));
                        }
                        else{
                          return Container();
                        }
                      }),

                ),

              ],
            ) : Container(),
          ],
        )
    );
  }
}
