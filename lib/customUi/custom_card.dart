import 'package:chatapp/model/chat_model.dart';
import 'package:chatapp/screens/individual_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.chatModel,required this.sourcechat});

  final ChatModel chatModel;
  final ChatModel sourcechat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualPage(
                      chatModel: chatModel, sourcechat: sourcechat,
                    )
            )
        );
      },
      child: SizedBox(
        height: 70,
        child: ListTile(
          leading: CircleAvatar(
              radius: 23,
              backgroundColor: Colors.black,
              child: SvgPicture.asset(
                chatModel.isGroup! ? "assets/groups.svg" : "assets/person.svg",
                height: 30,
                width: 30,
                color: Colors.white,
              )),
          title: Text(
            chatModel.name!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: [
              Icon(
                Icons.done_all,
                size: 13,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(chatModel.currentMessage!, style: TextStyle(fontSize: 13)),
            ],
          ),
          trailing: Text(chatModel.time!),
        ),
      ),
    );
  }
}
