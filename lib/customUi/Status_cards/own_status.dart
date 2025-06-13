import 'package:flutter/material.dart';

class OwnStatus extends StatelessWidget {
  const OwnStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/me.jpg"),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                backgroundColor: Colors.greenAccent[700],
                radius: 10,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ))
        ],
      ),
      title: Text(
          "My Status",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      subtitle: Text(
        "Tap to add status update",
        style: TextStyle(fontSize: 13, color: Colors.grey[900]),
      ),
    );
  }
}
