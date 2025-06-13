import 'dart:io';

import 'package:flutter/material.dart';

class OwnFileCard extends StatelessWidget {
  const OwnFileCard({super.key, this.path,this.message, this.time});

  final String? path;
  final String? message;
  final String? time;


  @override
  Widget build(BuildContext context) {

    final double cardHeight = (message == null || message!.trim().isEmpty)
        ? MediaQuery.of(context).size.height / 2.2
        : MediaQuery.of(context).size.height / 2.1;

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        child: Container(
            height: cardHeight,
            width: MediaQuery.of(context).size.width/1.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.green[300],
            ),
            child: Card(
              margin: EdgeInsets.all(2.5),
              child: Column(
                children: [
                  Image.file(File(path!),fit: BoxFit.fitHeight,),
                  Text(message!,style: TextStyle(color: Colors.black),),
                ],
              ),
            ),
          ),
            // Text("15:08",style: TextStyle(fontSize: 12),),
            // const SizedBox(width: 4,),
            // Icon(Icons.done_all, size: 17,)


      ),
    );
  }
}
