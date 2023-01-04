import 'package:accelth/Screens/OnBoard/onboarding_screen.dart';
import 'package:accelth/Screens/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/sign.dart';
import '../../utils/utils.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  bool obscureText = true;
  bool _emailValidate = false;
  bool _phoneValidate = false;
  bool _passwordValidate = false;
  Utils utils = Utils();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final data = Provider.of<SignInOrRegister>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.05),
            child: Column(
              children: [
                SizedBox(
                  height: height*0.08,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('Sign Up', style: TextStyle(fontSize: 38, fontWeight: FontWeight.w500),),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.only(
                    right: width * 0.04,
                    left: width * 0.04,
                    top: height * 0.005,
                    bottom: height * 0.005,
                  ),
                  child: TextField(
                    enableSuggestions: true,
                    cursorColor: Color(0XFF0957DE),
                    showCursor: true,
                    keyboardType: TextInputType.emailAddress,
                    enableIMEPersonalizedLearning: true,
                    decoration: InputDecoration(
                      errorText: _emailValidate ? "Enter a valid Email address" : null,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.4)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0XFF0957DE),),
                      ),
                      hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
                      hintText: 'Enter email id here',
                      icon: Icon(Icons.outgoing_mail, color: Colors.black,),
                    ),
                    controller: _emailController,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    //color: const Color.fromRGBO(216,252,8,0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.only(
                    right: width * 0.04,
                    left: width * 0.04,
                    top: height * 0.005,
                    bottom: height * 0.005,
                  ),
                  child: TextField(
                    enableSuggestions: true,
                    cursorColor: Color(0XFF0957DE),
                    showCursor: true,
                    keyboardType: TextInputType.emailAddress,
                    enableIMEPersonalizedLearning: true,
                    maxLength: 10,
                    decoration: InputDecoration(
                      errorText: _phoneValidate ? 'Enter a valid number': null,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.4)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0XFF0957DE),),
                      ),
                      hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
                      hintText: 'Enter your phone number',
                      icon: Icon(Icons.phone, color: Colors.black,),
                    ),
                    controller: _phoneController,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    //color: const Color.fromRGBO(216,252,8,0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.only(
                    right: width * 0.04,
                    left: width * 0.04,
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
                      hintStyle: const TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
                      hintText: 'Enter your password here',
                      icon: const Icon(Icons.lock_person_rounded, color: Colors.black,),
                      suffix: GestureDetector(
                        child: obscureText?Icon(Icons.visibility_off_outlined, color: Colors.black,size: 23):Icon(Icons.visibility_outlined, color: Color(0XFF0957DE),size: 23),
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
                    ),
                  ),
                ),
                SizedBox(
                  height: height*0.08,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "By logging in, you agree to our ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: width*0.035, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "terms and conditions",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: width*0.035, fontWeight: FontWeight.w400,color:Color(0XFF0957DE)),
                        ),
                        Text(
                          "and",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: width*0.035, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Text(
                      "Privacy Policy",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: width*0.035, fontWeight: FontWeight.w400,color:Color(0XFF0957DE)),
                    ),
                  ],
                ),
                SizedBox(
                  height: height*0.02,
                ),
                Text(
                  "Need Help ? Get in touch!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: width*0.035, fontWeight: FontWeight.w400,color:Color(0XFF0957DE)),
                ),
                SizedBox(
                  height: height*0.08,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0XFF0957DE)),
                    fixedSize: MaterialStateProperty.all(Size(width * 1, height * 0.06)),
                    elevation: MaterialStateProperty.all(10.0),
                    shadowColor: MaterialStateProperty.all<Color>(Colors.black54),
                  ),
                  onPressed: () {
                    setState(() {
                      _emailController.text.isEmpty ? _emailValidate = true: _emailValidate = false;
                      _phoneController.text.isEmpty ? _phoneValidate = true : _phoneValidate = false;
                      _phoneController.text.length!=10 ? _phoneValidate = true : _phoneValidate = false;
                      _passwordController.text.length<8 ? _passwordValidate = true : _passwordValidate = false;
                    });
                    if(!_emailValidate && !_passwordValidate && !_phoneValidate)
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> OnBoardScreen(email: _emailController.text,phoneno: _phoneController.text,password: _passwordController.text,)));
                  },
                  child: Text("Continue", style: TextStyle(fontSize: height*0.02),),
                ),
                SizedBox(
                  height: height*0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Joined us before? ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignIn()));
                      },
                        child: const Text('Login.',style: TextStyle(fontWeight: FontWeight.w600, color: Color(0XFF0957DE),fontSize: 18),)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
