import 'package:chatapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../screens/landing_page.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.countryCode, required this.number});

  final String countryCode;
  final String number;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          "Verify ${widget.countryCode} ${widget.number}",
          style: TextStyle(
              fontSize: 20,
              color: Colors.blue[700],
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            const SizedBox(height: 37,),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
              children: [
                TextSpan(
                  text: "We have sent an SMS to ",
                  style: TextStyle(fontSize: 16,
                  color: Colors.black)
                ),
                TextSpan(
                    text: "+" + widget.countryCode.substring(1)+" "+widget.number,
                    style: TextStyle(fontSize: 17,
                        color: Colors.black,
                    fontWeight: FontWeight.bold)
                ),
                TextSpan(
                    text: " Wrong number ?",
                    style: TextStyle(fontSize: 16,
                        color: Colors.cyan)
                ),
              ]
            )),

            const SizedBox(height: 17,),

            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 30,
              style: TextStyle(
                  fontSize: 17
              ),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                print("Completed: " + pin);
              },
            ),
            const SizedBox(height: 7,),
            
            Text("Enter 6-digit Otp", style: TextStyle(color: Colors.grey),),

            const SizedBox(height: 40,),

            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>LndingPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.message,color: Colors.teal,size: 25,),
                  const SizedBox(width: 17,),
                  Text("Resend Otp",style: TextStyle(color: Colors.teal, fontSize: 18))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
