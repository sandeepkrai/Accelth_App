import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/utils.dart';


class consentForm extends StatefulWidget {
  const consentForm({Key? key}) : super(key: key);

  @override
  State<consentForm> createState() => _consentFormState();
}

class _consentFormState extends State<consentForm> {
  bool? check1 = false;
  bool check2 = false;
  bool check3 = false;
  bool loading = false;
  Utils utils = Utils();
  void postImg(String path, String filename) async{
    var dio = Dio();
    // var map = new Map<String, dynamic>();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String obtainedEmail = sharedPreferences.getString('Email_id').toString();
    // map['file'] = file;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(path,filename: filename)
    });
    try {
      Response response = await dio.post('http://10.0.2.2:8000/file/upload/'+obtainedEmail, data: formData);
      if(response.statusCode==200){
        setState(() {
          loading = false;
        });
        utils.toastmessage("File Uploaded Successfully");
      }
      else if(response.statusCode==400){
        setState(() {
          loading = false;
        });
        utils.toastmessage("Unable to Upload file");
      }
    }catch(err){
      utils.toastmessage("Server Error.Try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    void openFile(PlatformFile file)
    {
      OpenFile.open(file.path!);
    }

    return Scaffold(
      backgroundColor: Color(0xFFF7FCFF),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: height,

            color: Color(0xFFF7FCFF),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back)),
                    Text("Upload Records", style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
                SizedBox(
                  height: height*0.01,
                ),

                Row(
                  children: [

                    Checkbox(value: check1, onChanged: (newBool){
                      setState(() {
                        check1=newBool;

                      });
                    },
                      activeColor: Colors.black,
                    ),
                    Expanded(child:Text("I voluntarily consent to authorize my health care provider to use or disclose my health information during the term of the term of my medical treatment.",
                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: width*0.04),
                    )
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.01,
                ),
                Row(
                  children: [

                    Checkbox(value: check2, onChanged: (newBool){
                      setState(() {
                        check2=newBool!;

                      });
                    },
                      activeColor: Colors.black,
                    ),
                    Expanded(child:Text("I authorize that all of my health information that the provider has in his or her possession, includinginformation relating to any medical history, mental or physical condition and anytreatment received by me.",
                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: width*0.04),
                    )
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.01,
                ),
                Row(
                  children: [

                    Checkbox(value: check3, onChanged: (newBool){
                      setState(() {
                        check3=newBool!;

                      });
                    },
                      activeColor: Colors.black,
                    ),
                    Expanded(child:Text("I understand that this Authorization will remain in effect for 25 days.",
                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: width*0.04),
                    )
                    ),

                  ],
                ),
                SizedBox(height: height*0.03,),
                Container(
                  padding: EdgeInsets.only(left: width*0.05),
                  child: (check1==false || check2==false || check3==false)?
                  Text("Please accept all the three terms and conditions!!", style: TextStyle(color: Colors.red, fontSize: width*0.04, fontWeight: FontWeight.w600),):
                  Text(""),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin:  EdgeInsets.symmetric(vertical:height*0.05,horizontal: width*0.03),
                      width: width*0.6,

                      child: ElevatedButton(
                        onPressed: (check1==false || check2==false || check3==false)?
                            (){}:
                            () async {
                          final result=await FilePicker.platform.pickFiles();
                          if (result==null)
                          {
                            return;
                          }
                          final file=result.files.first;
                          // openFile(file);
                          final path = file.path;
                          final filename = file.name;
                          postImg(path.toString(),filename.toString());
                        },
                        child: loading ? const CircularProgressIndicator(strokeWidth: 3, color: Colors.white ,) :Text('Upload ',style: TextStyle(fontSize: width*0.04),),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xff0957DE)),
                            padding: MaterialStateProperty.all(EdgeInsets.all(height*0.017)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            elevation: MaterialStateProperty.all(05)
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}