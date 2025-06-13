import 'package:chatapp/customUi/Status_cards/others_status.dart';
import 'package:chatapp/customUi/Status_cards/own_status.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            height: 45,
            width: 45,
            child: FloatingActionButton(
                backgroundColor: Colors.blueGrey[100],
                child: Icon(
                  Icons.edit,
                  color: Colors.blueGrey[900],
                ),
                onPressed: () {})
        ),
        const SizedBox(height: 16,),

        Container(
          height: 65,
          width: 65,
          child: FloatingActionButton(
              backgroundColor: Colors.greenAccent[700],
              child: Icon(
                Icons.camera_enhance,
                color: Colors.white,
                size: 30,
              ),
              onPressed: (){}),
        ),
        const SizedBox(height: 26,),
      ],
    ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OwnStatus(),
            label("Recent Updates"),
            OthersStatus(
              name: 'Supratim',
              time: '15:08',
              imageName: 'assets/me.jpg',
              isSeen: false,
              statusNum: 1,
            ),
            OthersStatus(
              name: 'Supratim',
              time: '15:08',
              imageName: 'assets/me.jpg',
              isSeen: false,
              statusNum: 5,),
            OthersStatus(
              name: 'Supratim',
              time: '15:08',
              imageName: 'assets/me.jpg',
              isSeen: false,
              statusNum: 6,),

            label("Viewed Updates"),
            OthersStatus(
              name: 'Supratim',
              time: '15:08',
              imageName: 'assets/me.jpg',
              isSeen: true,
              statusNum: 3,),
            OthersStatus(
              name: 'Supratim',
              time: '15:08',
              imageName: 'assets/me.jpg',
              isSeen: true,
              statusNum: 4,),
          ],
        ),
      ),
    );
  }
  Widget label(String labelname){
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 5),
        child: Text(labelname, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
      ),
    );
  }
}
