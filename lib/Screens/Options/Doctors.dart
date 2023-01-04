import 'dart:convert';

import 'package:accelth/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/PatientModel.dart';
class DoctorPage extends StatefulWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {

  Future<PatientModel> getPatientApi() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String obtainedEmail = sharedPreferences.getString('Email_id').toString();
    final response = await http.get(Uri.parse(patientUrl+obtainedEmail));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return PatientModel.fromJson(data);
    } else {
      return PatientModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0957DE),
          borderRadius: BorderRadius.all(
              Radius.circular(height*0.01)),
        ),
        child: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          color: Colors.white,
          icon: const Icon(Icons.home),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: const Color(0xFFF7FCFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: const Icon(Icons.arrow_back)),
                    const Text('Doctors',style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500
                    ),),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.015),
                  child: Text('Doctors and hospitals previously consulted',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: width*0.04
                  ),),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.03),
                        child: Container(
                          height: height*0.04,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.3)
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(height*0.02)),
                            color: Colors.white,
                          ),
                          child: Row(
                            children:const [
                              Expanded(child: Icon(Icons.search)),
                              Expanded(flex: 4, child: Text('Search History')),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.03),
                        child: GestureDetector(
                          onTap: (){
                          },
                          child: Container(
                              height: height*0.04,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF0957DE),
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(height*0.02)),
                                color: const Color(0xFF0957DE),
                              ),
                              child: const Center(child: Text('Online Consultation',style: TextStyle(
                                color: Colors.white,
                              ),))
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                FutureBuilder(
                    future: getPatientApi(),
                    builder: (context,snapshot){
                      if (!snapshot.hasData) {
                        return SizedBox(
                          height: height*0.6,
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ),
                          ),
                        );
                      }
                      else{
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.doctors!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: EdgeInsets.only(top: height*0.014,left: width*0.005,right: width*0.005),
                              child: GestureDetector(
                                onTap: (){
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width*0.03),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height*0.02)),
                                      boxShadow: const [
                                        BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 0.5),
                                        blurRadius: 0.2, spreadRadius: 0.2,
                                      ),],),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: width*0.05),
                                            child: const CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              radius: 60,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: height*0.015,horizontal: width*0.1),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('${snapshot.data!.doctors![index].name}',style: TextStyle(
                                                  fontSize: height*0.018
                                                ),),
                                                Text('${snapshot.data!.doctors![index].degree}',style: TextStyle(
                                                    fontSize: height*0.014
                                                )),
                                                SizedBox(
                                                  height: height*0.005,
                                                ),
                                                Text('${snapshot.data!.doctors![index].specs}',style: TextStyle(
                                                    fontSize: height*0.018
                                                )),
                                                Text('${snapshot.data!.doctors![index].hospital}',style: TextStyle(
                                                    fontSize: height*0.014
                                                )),
                                                Padding(
                                                  padding: EdgeInsets.only(top: height*0.01),
                                                  child: GestureDetector(
                                                    onTap: (){
                                                    },
                                                    child: Container(
                                                        width: width*0.4,
                                                        height: height*0.04,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color(0xFF0957DE),
                                                            ),
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(height*0.02)),
                                                            color: const Color(0xFF0957DE)
                                                        ),
                                                        child: const Center(child: Text('Book Appointment',style: TextStyle(
                                                          color: Colors.white,
                                                        ),))
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                ),
                SizedBox(
                  height: height*0.1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
