import 'package:chatapp/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({super.key, required this.contact});

  final ChatModel contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
              children: [
                CircleAvatar(
                  radius: 27,
                  child: SvgPicture.asset("assets/person.svg",height: 30,width: 30,),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                      backgroundColor: Colors.blueGrey.withOpacity(0.7),
                      radius: 11,
                      child: Icon(Icons.clear,color: Colors.white,size: 18,)),
                )
              ]
          ),
          const SizedBox(height: 3,),
          Text(contact.name!)
        ],
      ),
    );
  }
}
