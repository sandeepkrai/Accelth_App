import 'dart:convert';

import 'package:accelth/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/PatientModel.dart';
import 'package:http/http.dart' as http;

class VitalsPage extends StatefulWidget {
  const VitalsPage({Key? key}) : super(key: key);

  @override
  State<VitalsPage> createState() => _VitalsPageState();
}

class _VitalsPageState extends State<VitalsPage> {
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
  
  List<bool> selected = [false,false,false,false,false];
  List<String> vitalUnitList = [
    'BPM',
    'mmHg',
    '%',
    'BPM',
    'F',
    'gm/dL',
    'mg/dL'
  ];
  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF7FCFF),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.arrow_back)),
                  const Text('Vitals',style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500
                  ),),
                ],
              ),
              FutureBuilder(
                  future: getPatientApi(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox(
                        height: height*0.3,
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.01),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7FCFF),
                            borderRadius: BorderRadius.all(
                                Radius.circular(height * 0.03)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              selected[0]== false ?
                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.015),
                                  child: Container(
                                      width: width*0.9,
                                      height: height*0.08,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: width*0.004,
                                            color: const Color(0xFF0957DE)
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(height*0.02)),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: width*0.04),
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.heart_broken_outlined,size: height*0.04,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: width*0.03,top: height*0.01),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text('Heart Rate',style: TextStyle(fontSize: 20),),
                                                            SizedBox(
                                                              height: height*0.005,
                                                            ),
                                                            Text('${snapshot.data!.vitals!.heartRate!.latestResult.toString()} ${vitalUnitList[0]}'),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: height*0.0745,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(height * 0.01),bottomRight: Radius.circular(height * 0.01)),
                                                color: const Color(0xFF0957DE).withOpacity(0.1),
                                              ),
                                              child: Center(
                                                child: Text(snapshot.data!.vitals!.heartRate!.status.toString(),style: TextStyle(
                                                  color: snapshot.data!.vitals!.heartRate!.status.toString() == 'CONCERN' ? Colors.red : Colors.black,
                                                  fontSize: 18,
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                                onTap: (){
                                  setState(() {
                                    selected[0]=true;
                                    selected[1]=false;
                                    selected[2]=false;
                                    selected[3]=false;
                                    selected[4]=false;
                                  });
                                },
                              ): GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selected[0]=false;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.015),
                                  child: Container(
                                      width: width*0.9,
                                      height: height*0.13,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: width*0.004,
                                            color: const Color(0xFF0957DE)
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(height*0.02)),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: width*0.04),
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.heart_broken_outlined,size: height*0.04,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: width*0.03,top: height*0.01),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text('Heart Rate',style: TextStyle(fontSize: 20),),
                                                            SizedBox(
                                                              height: height*0.005,
                                                            ),
                                                            SizedBox(height: height*0.01,),
                                                            Text('Latest result: ${snapshot.data!.vitals!.heartRate!.latestResult.toString()} ${vitalUnitList[0]}'),
                                                            SizedBox(height: height*0.01,),
                                                            Text('Average result: ${snapshot.data!.vitals!.heartRate!.avgResult.toString()} ${vitalUnitList[0]}'),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                color: Colors.white,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(snapshot.data!.vitals!.heartRate!.status.toString(),style: TextStyle(
                                                      color: snapshot.data!.vitals!.heartRate!.status.toString() == 'CONCERN' ? Colors.red : Colors.black,
                                                      fontSize: 18,
                                                    ),),
                                                    SizedBox(height: height*0.01,),
                                                    const Text('[60-100]',style: TextStyle(fontSize: 13),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ),
                              selected[1]==false ? GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selected[1]=true;
                                    selected[0]=false;
                                    selected[2]=false;
                                    selected[3]=false;
                                    selected[4]=false;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.015),
                                  child: Container(
                                      width: width*0.9,
                                      height: height*0.08,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: width*0.004,
                                            color: const Color(0xFF0957DE)
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(height*0.02)),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: width*0.04),
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.bloodtype_rounded,size: height*0.04,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: width*0.03,top: height*0.01),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text('Pressure',style: TextStyle(fontSize: 20),),
                                                            SizedBox(
                                                              height: height*0.005,
                                                            ),
                                                            Text('${snapshot.data!.vitals!.bloodPressure!.latestResult.toString()} ${vitalUnitList[1]}'),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: height*0.0745,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(height * 0.01),bottomRight: Radius.circular(height * 0.01)),
                                                color: const Color(0xFF0957DE).withOpacity(0.1),
                                              ),
                                              child: Center(
                                                child: Text(snapshot.data!.vitals!.bloodPressure!.status.toString(),style: TextStyle(
                                                  color: snapshot.data!.vitals!.bloodPressure!.status.toString() == 'CONCERN' ? Colors.red : Colors.black,
                                                  fontSize: 16,
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ): GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selected[1]=false;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.015),
                                  child: Container(
                                      width: width*0.9,
                                      height: height*0.13,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: width*0.004,
                                            color: const Color(0xFF0957DE)
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(height*0.02)),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: width*0.04),
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.bloodtype_rounded,size: height*0.04,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: width*0.03,top: height*0.01),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text('Pressure',style: TextStyle(fontSize: 20),),
                                                            SizedBox(
                                                              height: height*0.005,
                                                            ),
                                                            SizedBox(height: height*0.01,),
                                                            Text('Latest result:${snapshot.data!.vitals!.bloodPressure!.latestResult.toString()} ${vitalUnitList[1]}'),
                                                            SizedBox(height: height*0.01,),
                                                            Text('Average result:${snapshot.data!.vitals!.bloodPressure!.avgResult.toString()} ${vitalUnitList[1]}'),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                color: Colors.white,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(snapshot.data!.vitals!.bloodPressure!.status.toString(),style: TextStyle(
                                                      color: snapshot.data!.vitals!.bloodPressure!.status.toString() == 'CONCERN' ? Colors.red : Colors.black,
                                                      fontSize: 16,
                                                    ),),
                                                    SizedBox(height: height*0.01,),
                                                    const Text('[<120]',style: TextStyle(fontSize: 13),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ),
                              selected[2]==false ? GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selected[2]=true;
                                    selected[0]=false;
                                    selected[1]=false;
                                    selected[3]=false;
                                    selected[4]=false;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.015),
                                  child: Container(
                                      width: width*0.9,
                                      height: height*0.08,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: width*0.004,
                                            color: const Color(0xFF0957DE)
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(height*0.02)),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: width*0.04),
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.bubble_chart_outlined,size: height*0.04,
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: width*0.03,top: height*0.01),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text('Oxygen',style: TextStyle(fontSize: 20),),
                                                            SizedBox(
                                                              height: height*0.005,
                                                            ),
                                                            Text('${snapshot.data!.vitals!.oxygen!.latestResult.toString()} ${vitalUnitList[2]}'),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: height*0.0745,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(height * 0.01),bottomRight: Radius.circular(height * 0.01)),
                                                color: const Color(0xFF0957DE).withOpacity(0.1),
                                              ),
                                              child: Center(
                                                child: Text(snapshot.data!.vitals!.oxygen!.status.toString(),style: TextStyle(
                                                  color: snapshot.data!.vitals!.oxygen!.status.toString() == 'CONCERN' ? Colors.red : Colors.black,
                                                  fontSize: 18,
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ): GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selected[2]=false;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.015),
                                  child: Container(
                                      width: width*0.9,
                                      height: height*0.13,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: width*0.004,
                                            color: const Color(0xFF0957DE)
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(height*0.02)),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: width*0.04),
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.bubble_chart_outlined,size: height*0.04,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: width*0.03,top: height*0.01),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text('Oxygen',style: TextStyle(fontSize: 20),),
                                                            SizedBox(
                                                              height: height*0.005,
                                                            ),
                                                            SizedBox(height: height*0.01,),
                                                            Text('Latest result: ${snapshot.data!.vitals!.oxygen!.latestResult.toString()}${vitalUnitList[2]}'),
                                                            SizedBox(height: height*0.01,),
                                                            Text('Average result: ${snapshot.data!.vitals!.oxygen!.avgResult.toString()}${vitalUnitList[2]}'),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                color: Colors.white,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(snapshot.data!.vitals!.oxygen!.status.toString(),style: TextStyle(
                                                      color: snapshot.data!.vitals!.oxygen!.status.toString() == 'CONCERN' ? Colors.red : Colors.black,
                                                      fontSize: 16,
                                                    ),),
                                                    SizedBox(height: height*0.01,),
                                                    const Text('[>95]',style: TextStyle(fontSize: 13),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ),
                              selected[3]==false ? GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selected[3]=true;
                                    selected[0]=false;
                                    selected[1]=false;
                                    selected[2]=false;
                                    selected[4]=false;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.015),
                                  child: Container(
                                      width: width*0.9,
                                      height: height*0.08,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: width*0.004,
                                            color: const Color(0xFF0957DE)
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(height*0.02)),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: width*0.04),
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.air,size: height*0.04,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: width*0.03,top: height*0.01),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text('Respiratory',style: TextStyle(fontSize: 20),),
                                                            SizedBox(
                                                              height: height*0.005,
                                                            ),
                                                            Text('${snapshot.data!.vitals!.respiratory!.latestResult.toString()} ${vitalUnitList[3]}'),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: height*0.0745,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(height * 0.01),bottomRight: Radius.circular(height * 0.01)),
                                                color: const Color(0xFF0957DE).withOpacity(0.1),
                                              ),
                                              child: Center(
                                                child: Text(snapshot.data!.vitals!.respiratory!.status.toString(),style: TextStyle(
                                                  color: snapshot.data!.vitals!.respiratory!.status.toString() == 'CONCERN' ? Colors.red : Colors.black,
                                                  fontSize: 18,
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ): GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selected[3]=false;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.015),
                                  child: Container(
                                      width: width*0.9,
                                      height: height*0.13,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: width*0.004,
                                            color: const Color(0xFF0957DE)
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(height*0.02)),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: width*0.04),
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.air,size: height*0.04,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: width*0.03,top: height*0.01),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text('Respiratory',style: TextStyle(fontSize: 20),),
                                                            SizedBox(
                                                              height: height*0.005,
                                                            ),
                                                            SizedBox(height: height*0.01,),
                                                            Text('Latest result: ${snapshot.data!.vitals!.respiratory!.latestResult.toString()} ${vitalUnitList[3]}'),
                                                            SizedBox(height: height*0.01,),
                                                            Text('Average result: ${snapshot.data!.vitals!.respiratory!.avgResult.toString()} ${vitalUnitList[3]}'),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                color: Colors.white,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(snapshot.data!.vitals!.respiratory!.status.toString(),style: TextStyle(
                                                      color: snapshot.data!.vitals!.respiratory!.status.toString() == 'CONCERN' ? Colors.red : Colors.black,
                                                      fontSize: 16,
                                                    ),),
                                                    SizedBox(height: height*0.01,),
                                                    const Text('[12-16]',style: TextStyle(fontSize: 13),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ),
                              selected[4]==false ? GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selected[4]=true;
                                    selected[0]=false;
                                    selected[1]=false;
                                    selected[2]=false;
                                    selected[3]=false;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.015),
                                  child: Container(
                                      width: width*0.9,
                                      height: height*0.08,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: width*0.004,
                                            color: const Color(0xFF0957DE)
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(height*0.02)),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: width*0.04),
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.thermostat,size: height*0.04,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: width*0.03,top: height*0.01),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text('Temperature',style: TextStyle(fontSize: 20),),
                                                            SizedBox(
                                                              height: height*0.005,
                                                            ),
                                                            Text('${snapshot.data!.vitals!.temperature!.latestResult.toString()} ${vitalUnitList[4]}'),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: height*0.0745,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(height * 0.01),bottomRight: Radius.circular(height * 0.01)),
                                                color: const Color(0xFF0957DE).withOpacity(0.1),
                                              ),
                                              child: Center(
                                                child: Text(snapshot.data!.vitals!.temperature!.status.toString(),style: TextStyle(
                                                  color: snapshot.data!.vitals!.temperature!.status.toString() == 'CONCERN' ? Colors.red : Colors.black,
                                                  fontSize: 18,
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ): GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selected[4]=false;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.015),
                                  child: Container(
                                      width: width*0.9,
                                      height: height*0.13,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: width*0.004,
                                            color: const Color(0xFF0957DE)
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(height*0.02)),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: width*0.04),
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.thermostat,size: height*0.04,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: width*0.03,top: height*0.01),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text('Temperature',style: TextStyle(fontSize: 20),),
                                                            SizedBox(
                                                              height: height*0.005,
                                                            ),
                                                            SizedBox(height: height*0.01,),
                                                            Text('Latest result: ${snapshot.data!.vitals!.temperature!.latestResult.toString()} ${vitalUnitList[4]}'),
                                                            SizedBox(height: height*0.01,),
                                                            Text('Average result: ${snapshot.data!.vitals!.temperature!.avgResult.toString()} ${vitalUnitList[4]}'),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                color: Colors.white,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(snapshot.data!.vitals!.temperature!.status.toString(),style: TextStyle(
                                                      color: snapshot.data!.vitals!.temperature!.status.toString() == 'CONCERN' ? Colors.red : Colors.black,
                                                      fontSize: 16,
                                                    ),),
                                                    SizedBox(height: height*0.01,),
                                                    const Text('[97-99]',style: TextStyle(fontSize: 13),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
