import 'package:camera/camera.dart';
import 'package:chatapp/newScreen/landing_screen.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/newScreen/login_screen.dart';
import 'package:chatapp/screens/landing_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
        fontFamily: "OpenSans"
      ),
      home: LndingPage() ,
      debugShowCheckedModeBanner: false,
    );
  }
}

