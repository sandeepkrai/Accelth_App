import 'dart:convert';

import 'package:accelth/Screens/auth/signin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utils/utils.dart';

class OnBoardScreen extends StatefulWidget {
  final String email;
  final String phoneno;
  final String password;
  const OnBoardScreen({super.key, required this.email,required this.phoneno,required this.password});
  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  bool male = false;
  bool female = false;
  bool other = false;
  Utils utils = Utils();
  bool loading = false;
  void postdata() async{
    setState(() {
      loading = true;
    });
    var dio= Dio();
    var body=jsonEncode({
      "Email_id": widget.email.toString(),
      "Password": widget.password.toString(),
      "Name": _nameController.text.toString(),
      "Contact_Number": widget.phoneno.toString(),
      "Gender":  gender.toString(),
      "Bloodgroup": blood_grp.toString(),
      "Height": _heightController.text.toString(),
      "Weight": _weightController.text.toString(),
      "DateofBirth":  _dateController.text.toString(),
      "Allergies": _allergiesController.text.toString(),
      "Blindcondition": colorblindness.toString(),
    });
    try {
      Response response = await dio.post(registerUrl, data: body);
      if(response.statusCode==200){
        setState(() {
          loading = false;
        });
        utils.toastmessage("Patient has been successfully added");
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignIn()));
      }
      if(response.statusCode == 400){
        utils.toastmessage(response.statusMessage.toString());
      }
    }catch(err){
      print(err.toString());
      utils.toastmessage(err.toString());
      setState(() {
        loading = false;
      });
    }
  }
  final _nameController=TextEditingController();
  final _dateController=TextEditingController();
  final _heightController=TextEditingController();
  final _weightController=TextEditingController();
  final _allergiesController=TextEditingController();
  List<String> defaultText= ["Select your blood group", "Select your color blindness condition"];
  List<String> blood=["A+","A-","B+","B-","AB+","AB-","O+","O-"];
  List<String> color=["Deuteranopia","Protanopia","Tritanopia"];
  String? colorblindness;
  String? blood_grp;
  String gender= "";
  BoxDecoration bd=BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black.withOpacity(0.3) , width: 1,));
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TextStyle title_style= TextStyle(fontSize: width*0.045,fontWeight: FontWeight.w500,);
    return Scaffold(
      backgroundColor: const Color(0xFFF7FCFF),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: const Color(0xFFF7FCFF),
            padding:  EdgeInsets.symmetric(horizontal: width*0.02),
            child: Column(
              children: [
                Text('On-boarding',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: width*0.06,
                      fontWeight: FontWeight.w500
                  ),),
                SizedBox(
                  height: height*0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Personal Details",style: TextStyle(fontSize: width*0.045, fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
                SizedBox(
                  height: height*0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Your Name ",style: title_style,),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: width*0.01),
                        decoration: bd,
                        child: TextField(
                          cursorColor: Color(0xFF0957DE),
                          decoration: const InputDecoration(
                            hintText: "Enter Your Name",
                            border: InputBorder.none,
                          ),
                          controller: _nameController,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height*0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Date of Birth",style: title_style),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: width*0.01),
                        decoration: bd,
                        child: TextFormField(
                          cursorColor: Color(0xFF0957DE),
                          decoration: const InputDecoration(
                            hintText: "Enter Your Date of Birth (dd/mm/yyyy)",
                            border:  InputBorder.none,
                          ),
                          controller: _dateController,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height*0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Gender ",style: title_style),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                male=true;
                                female = false;
                                other = false;
                                gender=male?"Male":"Not Selected";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: male? Color(0xFF0957DE):Colors.white,
                                  border: Border.all(
                                    color: Color(0xFF0957DE),
                                    width: 2,
                                  )
                              ),
                              height: height*0.04,
                              width: width*0.3,
                              //color: Colors.red,
                              child:  Center(child: Text("Male", style: TextStyle(color: male?Colors.white:Color(0xFF0957DE), fontWeight: FontWeight.w500),),),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                male = false;
                                female = true;
                                other = false;
                                gender=female?"Female":"Not Selected";
                              });
                            },
                            child: Container(
                              height: height*0.04,
                              width: width*0.3,
                              decoration: BoxDecoration(
                                  color: female?Color(0xFF0957DE):Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Color(0xFF0957DE),
                                    width: 2,
                                  )
                              ),
                              child:  Center(child: Text("Female", style:  TextStyle(color: female?Colors.white:Color(0xFF0957DE), fontWeight: FontWeight.w500),),),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                male = false;
                                female = false;
                                other= true;
                                gender = other?"Other":"Not Selected";
                              });
                            },
                            child: Container(
                              height: height*0.04,
                              width: width*0.3,
                              decoration: BoxDecoration(
                                  color: other?Color(0xFF0957DE):Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Color(0xFF0957DE),
                                    width: 2,
                                  )
                              ),
                              child:  Center(child: Text("Other", style: TextStyle(color: other?Colors.white:Color(0xFF0957DE), fontWeight: FontWeight.w500))),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height*0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Blood Group",style: title_style,),
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: width*0.04),
                          decoration:bd,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text(defaultText[0]),
                              isExpanded: true,
                              value: blood_grp,
                              onChanged: (value){
                                setState(() {
                                  blood_grp=value;
                                });
                              },
                              items: blood.map((value){
                                return DropdownMenuItem(value:value, child: Text(value),);
                              }).toList( ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height*0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Height (cms)",style: title_style,),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width*0.02),
                        decoration: bd,
                        child: TextFormField(
                          cursorColor: Color(0xFF0957DE),
                          decoration: const InputDecoration(
                            hintText: "Enter your Height (Optional)",
                            border: InputBorder.none,
                          ),
                          controller: _heightController,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height*0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Weight (kgs)",style: title_style,),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width*0.02),
                        decoration: bd,
                        child: TextFormField(
                          cursorColor: Color(0xFF0957DE),
                          decoration:  InputDecoration(
                            hintText: "Enter your Weight (Optional)",
                            border: InputBorder.none,
                          ),
                          controller: _weightController,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height*0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text("We are here to make your journey accessible and personalised",style: TextStyle(fontSize: width*0.045, fontWeight: FontWeight.w500),)),
                        ],
                      ),
                      SizedBox(
                        height: height*0.04,
                      ),
                      Row(
                        children: [
                          Text("Do you have any allergies?",style: title_style,),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width*0.02),
                        decoration: bd,
                        child: TextFormField(
                          cursorColor: Color(0xFF0957DE),
                          decoration:  InputDecoration(
                            hintText: "Mention all your allergies here",
                            border: InputBorder.none,
                          ),
                          controller: _allergiesController,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height*0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Do you see colors differently?",style: title_style,),
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: width*0.02),
                          decoration: bd,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text(defaultText[1]),
                              isExpanded: true,
                              value: colorblindness,
                              onChanged: (value){
                                setState(() {
                                  colorblindness=value;
                                });
                              },
                              items: color.map((value){
                                return DropdownMenuItem(value:value, child: Text(value),);
                              }).toList( ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height*0.1,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0XFF0957DE)),
                    fixedSize: MaterialStateProperty.all(Size(width * 0.9, height * 0.06)),
                    elevation: MaterialStateProperty.all(10.0),
                    shadowColor: MaterialStateProperty.all<Color>(Colors.black54),
                  ),
                  onPressed: () async {
                    postdata();
                  },
                  child: loading ? const CircularProgressIndicator(strokeWidth: 3, color: Colors.white ,) : Text("Next", style: TextStyle(fontSize: height*0.02),),
                ),
                SizedBox(
                  height: height*0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
