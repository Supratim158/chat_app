import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({super.key, required this.message, required this.time});

  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 100,
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          color: Color(0xffdcf8c6),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 30, bottom: 17, top: 5),
                child: Text(message, style: TextStyle(fontSize: 16),),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [Text(time,style: TextStyle(fontSize: 12),),
                    const SizedBox(width: 4,),
                    Icon(Icons.done_all, size: 17,)],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
