import 'dart:convert';
import 'dart:io';
import 'package:chatapp/customUi/own_file_card.dart';
import 'package:chatapp/model/message_model.dart';
import 'package:chatapp/screens/camera_screen.dart';
import 'package:chatapp/screens/camera_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:chatapp/customUi/own_message_card.dart';
import 'package:chatapp/customUi/reply_card.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../customUi/reply_file_card.dart';
import '../model/chat_model.dart';
import '../pages/camera_page.dart';
import 'package:http/http.dart' as http;

class IndividualPage extends StatefulWidget {
  const IndividualPage(
      {super.key, required this.chatModel, required this.sourcechat});
  final ChatModel chatModel;
  final ChatModel sourcechat;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  final TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool showEmojiPicker = false;
  late IO.Socket socket;
  bool sendButton = false;
  late List<MessageModel> messages = [];
  ImagePicker _picker = ImagePicker();
  XFile? file;
  int popTime = 0;

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
    connect();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && showEmojiPicker) {
        setState(() {
          showEmojiPicker = false;
        });
      }
    });
  }

  void connect() {
    socket = IO.io("http://192.168.229.82:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", widget.sourcechat.id);
    socket.onConnect((data) {
      print("conntected");
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"],msg["path"]);
        _scrollController.position.maxScrollExtent;
        duration: Duration(milliseconds: 200);
      });
    });
    print(socket.connected);
  }

  void sendMessage(String message, int sourceId, int targetId, String path) {
    setMessage("source", message, path);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId, "path": path});
  }

  void setMessage(String type, String message, String path) {
    MessageModel messageModel = MessageModel(type, message,DateTime.now().toString().substring(10,16),path );
    setState(() {
        messages.add(messageModel);
    });
  }

  void onImageSend(String path, String message) async {
    print("Hey there $message");
    for(int i =0; i<popTime;i++){
      Navigator.pop(context);
    }
    setState(() {
      popTime=0;
    });

    var request = http.MultipartRequest("POST", Uri.parse("http://192.168.229.82:5000/routes/addimage"));
    request.files.add(await http.MultipartFile.fromPath("img",path));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    http.StreamedResponse response = await request.send();
    var httpResponse = await http.Response.fromStream(response);
    var data = json.decode(httpResponse.body);
    print(data['path']);
    setMessage("source", message, path);
    socket.emit("message",
        {"message": message, "sourceId": widget.sourcechat.id, "targetId": widget.chatModel.id, "path": data['path']});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/whatsapp_Back.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
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
                  child: IconButton(
                      icon: const Icon(Icons.phone), onPressed: () {}),
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
                child: Column(
                  children: [
                    Expanded(
                      // height: MediaQuery.of(context).size.height - 140,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: messages.length+1,
                        itemBuilder: (context, index) {
                          if(index==messages.length){
                            return Container(
                              height: 70,
                            );
                          }
                          if (messages[index].type == "source") {
                            if(messages[index].path != null){
                              return OwnFileCard(path: messages[index].path,
                                  message:messages[index].message,
                                time: messages[index].time,
                              );
                            }
                            else{
                              return OwnMessageCard(
                                message: messages[index].message!,
                                time: messages[index].time!,
                              );
                            }
                          } else {
                            return ReplyCard(
                              message: messages[index].message!,
                              time: messages[index].time!,
                            );
                          }
                        },
                      ),

                    ), // your chat messages here
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
                        onChanged: (value) {
                          if (value.length > 0) {
                            setState(() {
                              sendButton = true;
                            });
                          } else {
                            setState(() {
                              sendButton = false;
                            });
                          }
                        },
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
                                onPressed: () {
                                  setState(() {
                                    popTime=2;
                                  });
                                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>CameraScreen(onImageSend: onImageSend,)));
                                },
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
                        child: IconButton(
                          onPressed: () {
                            if (sendButton) {
                              _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeOut);
                              sendMessage(_controller.text,
                                  widget.sourcechat.id!, widget.chatModel.id!,"");
                              _controller.clear();
                              setState(() {
                                sendButton = false;
                              });
                            }
                          },
                          icon: Icon(sendButton ? Icons.send : Icons.mic,
                              color: Colors.white),
                        )),
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
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 290,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: Colors.black12,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 50),
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
                      () async {
                      setState(() {
                        popTime=2;
                      });
                      file = (await _picker.pickImage(source: ImageSource.gallery))!;
                      if (file != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CameraViewPage(
                                path: file?.path,
                                onImageSend: onImageSend,
                            ),
                          ),
                        );

                      } else {
                        // User canceled the image picker
                        print("No image selected");
                      }
                      },
                  ),
                  iconCreation(
                      Icons.camera_alt,
                      Colors.pink,
                      "Camera",
                        (){
                          setState(() {
                            popTime=3;
                          });
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>CameraScreen(onImageSend: onImageSend,)));
                        },
                    ),
                  iconCreation(
                    Icons.location_on,
                    Colors.greenAccent,
                    "Location",
                        (){},
                  ),
                  iconCreation(
                    Icons.person,
                    Colors.blueAccent,
                    "Contact",
                        (){},
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                iconCreation(
                  Icons.insert_drive_file_rounded,
                  Colors.deepPurple,
                  "Document",
                      (){},
                ),
                iconCreation(
                  Icons.headphones_rounded,
                  Colors.deepOrange,
                  "Audio",
                      (){},
                ),
                iconCreation(
                  Icons.poll_outlined,
                  Colors.yellow,
                  "Poll",
                      (){},
                ),
                iconCreation(
                  Icons.event,
                  Colors.pinkAccent,
                  "Event",
                      (){},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String titletext, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
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
          const SizedBox(
            height: 5,
          ),
          Text(
            titletext,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
