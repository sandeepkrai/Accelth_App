import 'dart:async';
import 'package:accelth/Screens/Home/homepage.dart';
import 'package:accelth/Screens/auth/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
String s = "";
class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
        ()async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          //Return String
          String stringValue = prefs.getString('Email_id')??"";
          if(stringValue == "")
            Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => Wrapper()));
          else{
            Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => homepage()));
          }
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: Image.asset('./assets/images/img_1.png',width: double.infinity,)),
          CircularProgressIndicator(
            strokeWidth: 2.0,
            color: Color(0xFF0957DE),)
        ],
      ),
    );
  }
}
