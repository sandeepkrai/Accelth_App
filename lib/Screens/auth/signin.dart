import 'dart:convert';

import 'package:accelth/Screens/Home/homepage.dart';
import 'package:accelth/Screens/auth/signup.dart';
import 'package:accelth/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/sign.dart';
import '../../utils/utils.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obscureText = true;
  Utils utils = Utils();
  bool loading = false;
  bool _emailValidate = false;
  bool _passwordValidate = false;
  void postdata() async{
    setState(() {
      loading = true;
    });
    var dio= Dio();
    var body=jsonEncode({
      "Email_id": _emailController.text.toString(),
      "Password": _passwordController.text.toString(),
    });
    try {
      Response response = await dio.post(loginUrl, data: body);
      if(response.statusCode==200){
        setState(() {
          loading = false;
        });
        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("Email_id", _emailController.text);
        utils.toastmessage("Login Successfully");
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>homepage()));
      }
      else if(response.statusCode==400){
        setState(() {
          loading = false;
        });
        utils.toastmessage("Login Failed");
      }
    }catch(err){
      utils.toastmessage("Server Error.Try again");
    }
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final data = Provider.of<SignInOrRegister>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.02,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: height*0.18,
              ),
              Align(
                       alignment: Alignment.centerLeft,
                       child: Text("Login", style: TextStyle(fontSize: width*0.11, fontWeight: FontWeight.w500),),
                   ),
              Container(
                    margin: EdgeInsets.symmetric(
                      vertical: height * 0.01,
                      horizontal: width* 0.01
                    ),
                    child: TextField(
                      enableSuggestions: true,
                      cursorColor: Color(0XFF0957DE),
                      showCursor: true,
                      enableIMEPersonalizedLearning: true,
                      decoration: InputDecoration(
                        errorText: _emailValidate ? "Enter a valid Email address" : null,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black.withOpacity(0.4)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF0957DE),),
                        ),
                        icon: Icon(Icons.mail, color: Colors.black,),
                        hintStyle: TextStyle(fontSize: 17),
                        hintText: 'Enter email id',
                      ),
                      controller: _emailController,
                    ),
                    ),
              Container(
                margin: EdgeInsets.only(
                  top: height * 0.01,
                ),
                child: TextField(
                  enableSuggestions: true,
                  cursorColor: Color(0XFF0957DE),
                  showCursor: true,
                  enableIMEPersonalizedLearning: true,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: obscureText,
                  controller: _passwordController,
                  autofocus: true,
                  decoration: InputDecoration(
                    errorText: _passwordValidate ? 'Enter a valid password': null,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black.withOpacity(0.4)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFF0957DE),),
                    ),
                    icon: const Icon(
                      Icons.lock_person_rounded,
                      color: Colors.black,
                    ),
                    suffix: GestureDetector(
                      child: obscureText?const Icon(Icons.visibility_off_outlined, color: Colors.black, size: 23):const Icon(Icons.visibility_outlined, color: Color(0XFF0957DE), size: 23),
                      onTap: (){
                        setState(() {
                          if(obscureText==true) {
                            obscureText = false;
                          } else {
                            obscureText = true;
                          }
                        });
                      },
                    ),
                    hintText: "Enter your Password",
                    hintStyle: const TextStyle(
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child:TextButton(
                  style: TextButton.styleFrom(
                    textStyle:  TextStyle(fontSize: width*0.035),
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Forgot Password?', style: TextStyle(fontWeight: FontWeight.w500, color: Color(0XFF0957DE)),),
                  onPressed: () async {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const homepage())
                    );
                  },
                ),
              ),
              ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0XFF0957DE)),
                        fixedSize: MaterialStateProperty.all(Size(width * 1, height * 0.06)),
                        elevation: MaterialStateProperty.all(10.0),
                        shadowColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                    ),
                    onPressed: () {
                      setState(() {
                        _emailController.text.isEmpty ? _emailValidate = true: _emailValidate = false;
                        _passwordController.text.length<8 ? _passwordValidate = true : _passwordValidate = false;
                      });
                      if(!_emailValidate && !_passwordValidate)
                      postdata();
                    },
                    child: loading ? const CircularProgressIndicator(strokeWidth: 3, color: Colors.white ,) : Text("Login", style: TextStyle(
                      fontSize: width*0.04,
                      fontWeight: FontWeight.w800,

                    ),),
                  ),
              Container(
                padding: EdgeInsets.symmetric(vertical: height*0.015),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: height*0.015),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(237, 237, 237, 1)),
                  fixedSize: MaterialStateProperty.all(Size(width * 0.9, height * 0.06)),
                  elevation: MaterialStateProperty.all(10.0),
                ),
                onPressed: () async {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const homepage())
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.network("https://cdn-icons-png.flaticon.com/512/300/300221.png?w=1380&t=st=1670516925~exp=1670517525~hmac=a87c316c72496adbbba01230d6b2e9f1106fd4860e4f98c6a9fff3bca640824f",
                    scale: 15.0,),
                    Text("Login With Google", style: TextStyle(
                      fontSize: width*0.045,
                      color: const Color(0XFF0957DE),
                      fontWeight: FontWeight.w700,
                    ),),
                  ],
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text('New to Accelth?', style: TextStyle( fontSize: width*0.045, fontWeight: FontWeight.w500),),
                  TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignUp()));
                },
                child:  Text('Sign up',style: TextStyle(fontSize: width*0.045,fontWeight: FontWeight.w500, color: const Color(0XFF0957DE)),),
              ),
              ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
