import 'package:chatapp/newScreen/login_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              "Welcome to ChatMe",
              style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 11),
            Image.asset(
              "assets/bg.png",
              color: Colors.greenAccent[700],
              height: 340,
              width: 320,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 17),
                      children: [
                        TextSpan(
                            text: "Agree & continue to accept the ",
                            style: TextStyle(color: Colors.grey[600])),
                        TextSpan(
                            text: "ChatMe Terms of Service & Privacy Policy",
                            style: TextStyle(color: Colors.greenAccent[700])),
                      ])),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 25),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => LoginScreen()),
                      (route) => false);
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 80,
                  child: Card(
                      color: Colors.greenAccent[700],
                      elevation: 12,
                      child: Center(
                          child: Text(
                        "Agree & Continue",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                            color: Colors.white),
                      ))),
                  // decoration:BoxDecoration(
                  //     color: Colors.greenAccent[700],
                  //   borderRadius: BorderRadius.circular(17)
                  // ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
