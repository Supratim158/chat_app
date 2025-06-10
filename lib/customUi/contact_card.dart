import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../model/chat_model.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact});

  final ChatModel contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(
          height: 53,
          width: 50,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 23,
                child: SvgPicture.asset("assets/person.svg",height: 30,width: 30,),
              ),
              contact.select!? Positioned(
                bottom: 4,
                right: 5,
                child: CircleAvatar(
                  backgroundColor: Colors.teal,
                    radius: 11,
                    child: Icon(Icons.check,color: Colors.white,size: 18,)),
              )
                  : Container()
            ]
          ),
        ),
        title: Text(
          contact.name!,
          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        subtitle: Text(
            contact.status!,
            style: TextStyle(fontSize: 13)),
    );
  }
}
