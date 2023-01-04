import 'dart:convert';

// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../../models/PatientModel.dart';

class FitbitPage extends StatefulWidget {
  const FitbitPage({Key? key}) : super(key: key);

  @override
  State<FitbitPage> createState() => _FitbitPageState();
}

class _FitbitPageState extends State<FitbitPage> {
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
  final List<String> vitalUnitList = [
    'BPM',
    'mmHg',
    '%',
    'BPM',
    'F',
    'gm/dL',
    'mg/dL'
  ];

  bool _animationFinished = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: const Icon(Icons.arrow_back)),
                const Text('Fitbit',style: TextStyle(
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
                    return Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: height * 0.01),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7FCFF),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(height * 0.03)),
                            ),
                            child: Column(
                              children: [
                                CircularPercentIndicator(
                                  reverse: true,
                                  radius: height*0.1,
                                  lineWidth: width*0.025,
                                  backgroundColor: const Color(0xFF0957DE).withOpacity(0.2),
                                  progressColor: const Color(0xFF0957DE),
                                  percent: snapshot.data!.medicalDevice!.fitbit!.numberofSteps!/10000,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: _animationFinished ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(snapshot.data!.medicalDevice!.fitbit!.numberofSteps.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                      const Text('Steps',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    ],
                                  ): const Text(''),
                                  animation: true,
                                  animationDuration: 500,
                                  onAnimationEnd: (){
                                    setState(() {
                                      _animationFinished = true;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.015),
                                  child: Container(
                                      width: width*0.9,
                                      height: height*0.055,
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
                                                      Icon(Icons.monitor_heart_outlined,size: height*0.04,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: width*0.03,top: height*0.001),
                                                        child: const Text('Number of steps',style: TextStyle(fontSize: 20),),
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
                                                child: Text(snapshot.data!.medicalDevice!.fitbit!.numberofSteps.toString(),style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.015),
                                  child: Container(
                                      width: width*0.9,
                                      height: height*0.055,
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
                                                      Icon(Icons.monitor_heart_outlined,size: height*0.04,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: width*0.03,top: height*0.001),
                                                        child: const Text('Distance',style: TextStyle(fontSize: 20),),
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
                                                child: Text(snapshot.data!.medicalDevice!.fitbit!.distance.toString(),style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.015),
                                  child: Container(
                                      width: width*0.9,
                                      height: height*0.055,
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
                                                        Icons.monitor_heart_outlined,size: height*0.04,
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: width*0.03,top: height*0.001),
                                                        child: const Text('Calories',style: TextStyle(fontSize: 20),),
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
                                                child: Text(snapshot.data!.medicalDevice!.fitbit!.calories.toString(),style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: width*0.03,right: width*0.02),
                                          child: Container(
                                            height: height*0.2,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(height * 0.02)),
                                              color: const Color(0xFF0957DE),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text('Fat Burn',style: TextStyle(color: Colors.white,fontSize: width*0.035),),
                                                Icon(FontAwesomeIcons.fire,color: Colors.white,size: width*0.07,),
                                                Text(snapshot.data!.medicalDevice!.fitbit!.fatBurn.toString(),style: TextStyle(color: Colors.white,fontSize: width*0.035),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: width*0.02, right: width*0.02),
                                          child: Container(
                                            height: height*0.2,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(height * 0.02)),
                                              color: const Color(0xFF0957DE),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text('Cardio',style: TextStyle(color: Colors.white,fontSize: width*0.035),),
                                                Icon(FontAwesomeIcons.heart,color: Colors.white,size: width*0.07,),
                                                Text(snapshot.data!.medicalDevice!.fitbit!.cardio.toString(),style: TextStyle(color: Colors.white,fontSize: width*0.035),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: width*0.02, right: width*0.03),
                                          child: Container(
                                            height: height*0.2,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(height * 0.02)),
                                              color: const Color(0xFF0957DE),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text('Peak',style: TextStyle(color: Colors.white,fontSize: width*0.035),),
                                                Icon(FontAwesomeIcons.thinkPeaks,color: Colors.white,size: width*0.07,),
                                                Text(snapshot.data!.medicalDevice!.fitbit!.peak.toString(),style: TextStyle(color: Colors.white,fontSize: width*0.035),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.05),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.directions_run_outlined,size: height*0.03,),
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: height*0.003,horizontal: width*0.02),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Fitness'),
                                                SizedBox(
                                                  height: height*0.015,
                                                ),
                                                const Text('Weekly active zone graph'),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      //Space left for graph
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.05),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(FontAwesomeIcons.moon,size: height*0.03,),
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: height*0.003,horizontal: width*0.02),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Sleep Cycle'),
                                                SizedBox(
                                                  height: height*0.015,
                                                ),
                                                const Text('Weekly sleep cycle'),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      //Space left for graph
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}


