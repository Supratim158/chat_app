import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../model/chat_model.dart';

class IndividualPage extends StatefulWidget {
  const IndividualPage({super.key, required this.chatModel});
  final ChatModel chatModel;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool showEmojiPicker = false;

  void _toggleEmojiPicker() {
    if (showEmojiPicker) {
      _focusNode.requestFocus();
    } else {
      _focusNode.unfocus();
    }
    setState(() {
      showEmojiPicker = !showEmojiPicker;
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && showEmojiPicker) {
        setState(() {
          showEmojiPicker = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Colors.blueAccent,
          leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.black.withOpacity(0.03),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 2.0),
                    child: Icon(Icons.arrow_back_ios_new),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blueGrey,
                    child: SvgPicture.asset(
                      widget.chatModel.isGroup!
                          ? "assets/groups.svg"
                          : "assets/person.svg",
                      height: 30,
                      width: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          title: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.chatModel.name!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Last seen today at 12:00",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: IconButton(
                  icon: const Icon(Icons.videocam), onPressed: () {}),
            ),
            const SizedBox(width: 3),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child:
                  IconButton(icon: const Icon(Icons.phone), onPressed: () {}),
            ),
            const SizedBox(width: 3),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: PopupMenuButton<String>(
                onSelected: (value) {},
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                        child: Text("New group"), value: "New group"),
                    const PopupMenuItem(
                        child: Text("New group"), value: "New group"),
                    const PopupMenuItem(
                        child: Text("New group"), value: "New group"),
                    const PopupMenuItem(
                        child: Text("New group"), value: "New group"),
                  ];
                },
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ListView(), // your chat messages here
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 60,
                child: Card(
                  margin: const EdgeInsets.only(left: 5, bottom: 7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                  ),
                  child: TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.emoji_emotions_sharp),
                        onPressed: _toggleEmojiPicker,
                      ),
                      hintText: "Message...",
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.attach_file_sharp),
                            onPressed: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (builder) => bottomSheet());
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.camera_alt_outlined),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      contentPadding: const EdgeInsets.only(top: 10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, bottom: 8.0),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blueAccent,
                  child: const Icon(Icons.mic, color: Colors.white),
                ),
              ),
            ],
          ),
          Offstage(
            offstage: !showEmojiPicker,
            child: SizedBox(
              height: 300,
              child: EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  _controller.text += emoji.emoji;
                  _controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: _controller.text.length),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
        height: 290,
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Colors.black12,
          margin: EdgeInsets.only(left: 10, right: 10,bottom: 50),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    iconCreation(
                      Icons.image_rounded,
                      Colors.blue,
                      "Gallery",
                    ),
                    iconCreation(
                      Icons.camera_alt,
                      Colors.pink,
                      "Camera",
                    ),
                    iconCreation(
                      Icons.location_on,
                      Colors.greenAccent,
                      "Location",
                    ),
                    iconCreation(
                      Icons.person,
                      Colors.blueAccent,
                      "Contact",
                    ),
                  ],
                ),

              ),

              const SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  iconCreation(
                    Icons.insert_drive_file_rounded,
                    Colors.deepPurple,
                    "Document",
                  ),
                  iconCreation(
                    Icons.headphones_rounded,
                    Colors.deepOrange,
                    "Audio",
                  ),
                  iconCreation(
                    Icons.poll_outlined,
                    Colors.yellow,
                    "Poll",
                  ),
                  iconCreation(
                    Icons.event,
                    Colors.pinkAccent,
                    "Event",
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String titletext) {
    return InkWell(
      onTap: (){},
      child: Column(
        children: [
          Container(
            width: 60, // Matches CircleAvatar's diameter (radius: 30)
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black38, // Same background color
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            child: Icon(
              icon,
              size: 35,
              color: color,
            ),
          ),
          const SizedBox(height: 5,),
          Text(titletext,style: TextStyle(color: Colors.white),),
        ],
      ),
    );
  }
}
