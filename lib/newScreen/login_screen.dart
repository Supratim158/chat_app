import 'package:chatapp/model/country_model.dart';
import 'package:chatapp/newScreen/country_page.dart';
import 'package:chatapp/newScreen/otp_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String countryName = "India";
  String countryCode = "+91";
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Enter Your Phone No.",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.greenAccent[700]),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(child: Text("New group"), value: "New group"),
                  PopupMenuItem(child: Text("New group"), value: "New group"),
                  PopupMenuItem(child: Text("New group"), value: "New group"),
                  PopupMenuItem(child: Text("New group"), value: "New group"),
                ];
              })
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "ChatMe will send you a sms to verify your number",
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              "What's my number?",
              style: TextStyle(fontSize: 13, color: Colors.greenAccent[700]),
            ),
            const SizedBox(
              height: 20,
            ),
            countryCard(),
            const SizedBox(
              height: 5,
            ),
            number(),
            Expanded(child: Container()),
            Center(
              child: GestureDetector(
                onTap: () {
                  if (_controller.text.length < 10) {
                    showMyDialog1();
                  } else {
                    showMyDialog();
                  }
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 80,
                  child: Card(
                      color: Colors.greenAccent[700],
                      elevation: 12,
                      child: Center(
                          child: Text(
                        "Next",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                            color: Colors.white),
                      ))),
                ),
              ),
            ),
            Container(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget countryCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => CountryPage(
                      setCountryData: setCountryData,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.teal, width: 1.8)),
        ),
        child: Row(
          children: [
            Expanded(
                child: Container(
                    child: Center(
                        child: Text(
              countryName,
              style: TextStyle(fontSize: 17),
            )))),
            Icon(
              Icons.arrow_drop_down_sharp,
              color: Colors.teal,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget number() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: 38,
      child: Row(
        children: [
          Container(
            height: 45,
            width: 50,
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.teal, width: 1.8)),
            ),
            child: Row(
              children: [
                Text(
                  " +",
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  countryCode.substring(1),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.5 - 70,
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.teal, width: 1.8)),
            ),
            child: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(9),
                  hintText: "Phone no"),
            ),
          ),
        ],
      ),
    );
  }

  void setCountryData(CountryModel countryModel) {
    setState(() {
      countryName = countryModel.name!;
      countryCode = countryModel.code!;
    });
    Navigator.pop(context);
  }

  Future<void> showMyDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("We'll be verifying your phone number"),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    countryCode + " " + _controller.text,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text("The number is correct or you want to edit it ?"),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Edit",
                      style: TextStyle(color: Colors.teal, fontSize: 15))),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => OtpScreen(
                                  countryCode: countryCode,
                                  number: _controller.text,
                                )));
                  },
                  child: Text("ok",
                      style: TextStyle(color: Colors.teal, fontSize: 15))),
            ],
          );
        });
  }

  Future<void> showMyDialog1() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Please enter a valid 10 digit number !!!"),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok",
                      style: TextStyle(color: Colors.teal, fontSize: 15))),
            ],
          );
        });
  }
}
